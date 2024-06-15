terraform {
  backend "s3" {
    bucket         = "toba-infra-tf-state"
    key            = "infra-tf-state"          
    region         = "eu-west-2"                  
  }
}