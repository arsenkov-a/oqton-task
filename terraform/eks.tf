
locals {
  eks_cluster_name = var.eks_cluster_name != null ? var.eks_cluster_name : var.environment_name
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.6.0"

  cluster_endpoint_public_access = var.eks_cluster_endpoint_public_access
  cluster_version                = var.eks_cluster_version
  cluster_name                   = local.eks_cluster_name
  cluster_addons                 = var.eks_cluster_addons
  eks_managed_node_groups        = var.eks_managed_node_groups
  manage_aws_auth_configmap      = var.eks_manage_aws_auth_configmap
  subnet_ids                     = module.network.private_subnets
  vpc_id                         = module.network.vpc_id
}

