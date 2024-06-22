provider "aws" {
  region = "us-west-2"  # Replace with your preferred AWS region
  profile = "dns"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"  # Path to your kubeconfig file
  }
}

