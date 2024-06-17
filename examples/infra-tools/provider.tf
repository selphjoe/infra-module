terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.17.0"
    }
  }
}

provider "kubernetes" {
    config_path    = var.config_path
    config_context = var.config_context
}

provider "helm" {
  kubernetes {
    config_path    = var.config_path
    config_context = var.config_context
  }
}

provider "aws" {
  region = "eu-west-2"
  
}