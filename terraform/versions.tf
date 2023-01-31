terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.39"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.16"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.8.0"
    }
  }
  required_version = ">= 1.0.11"
}

