data "aws_availability_zones" "azs" {}

locals {
  availability_zones = slice(data.aws_availability_zones.azs.names, 0, var.azs_count)
  subnets = cidrsubnets(
    var.vpc_cidr,
    concat(
      [for az in range(var.azs_count) : var.private_subnets_newbits],
      [for az in range(var.azs_count) : var.public_subnets_newbits]
    )...
  )
}

module "network" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name                 = var.environment_name
  azs                  = local.availability_zones
  cidr                 = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_nat_gateway   = var.enable_nat_gateway
  private_subnets      = slice(local.subnets, 0, var.azs_count)
  public_subnets       = slice(local.subnets, var.azs_count, var.azs_count * 2)
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }
}
