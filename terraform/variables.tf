variable "aws_region" {
  description = "Target AWS region"
}

variable "azs_count" {
  description = "Number of availability zones for VPC"
  default     = 3
}

variable "eks_cluster_addons" {
  description = "Map of EKS cluster addons to install"
  type        = map(any)
  default = {
    aws-ebs-csi-driver = {
      most_recent = true
    }
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
  }
}

variable "eks_cluster_endpoint_public_access" {
  description = "Allow public access to cluster endpoint"
  default     = true
}

variable "eks_cluster_name" {
  description = "Target EKS cluster name, if not provided - environment name is used instead"
  default     = null
}

variable "eks_cluster_version" {
  description = "EKS cluster version"
  default     = "1.23"
}

variable "eks_create_cloudwatch_log_group" {
  description = "Create cloudwatch log group for cluster logs or not"
  default     = false
}

variable "eks_manage_aws_auth_configmap" {
  description = "Whether manage aws-auth configmap by terraform or not"
  default     = true
}

variable "eks_managed_node_groups" {
  description = "Map of EKS managed node groups for cluster"
  type        = map(any)
  default = {
    main = {
      desired_size   = 2
      max_size       = 3
      min_size       = 1
      instance_types = ["t3.medium"]
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }
    }
  }
}

variable "enable_dns_hostnames" {
  description = "Enabled DNS hostnames in VPC"
  default     = true
}

variable "enable_nat_gateway" {
  description = "Deploy NAT gateways for private subnets or not"
  default     = true
}

variable "environment_name" {
  description = "Target environment name"
}

variable "helm_charts" {
  description = "Map of helm charts to deploy"
  type        = map(any)
  default     = {}
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  default     = "10.0.0.0/16"
}

variable "private_subnets_newbits" {
  description = "Number of additional bits to extend network prefix for private subnets"
  default     = 2
}

variable "public_subnets_newbits" {
  description = "Number of additional bits to extend network prefix for public subnets"
  default     = 7
}
