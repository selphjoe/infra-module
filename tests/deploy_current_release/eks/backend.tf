terraform {
  backend "s3" {
    bucket         = "toba-infra-tf-state"
    key            = "infra-module-eks-state"          
    region         = "eu-west-2"                  
  }
}