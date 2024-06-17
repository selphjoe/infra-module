terraform {
  backend "s3" {
    bucket         = "oyg-infra-tf-state"
    key            = "infra-module-eks-state"          
    region         = "eu-west-2"                  
  }
}