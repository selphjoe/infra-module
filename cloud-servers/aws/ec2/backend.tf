terraform {
  backend "s3" {
    bucket         = "toba-infra-tf-state"
    key            = "infra-module-ec2-state"          
    region         = "eu-west-2"                  
  }
}