variable "region" {
    type = string
    default = "eu-west-2"  
}

variable "env" {
    type = string
    default = "Dev"
  
}

variable "tf_state_bucket_key" {
  type = string
  default = "infra-tf-state"
}


variable "tf_state_bucket_name" {
    type = string
    default = "toba-infra-tf-state"
  
}

variable "tf_state_bucket_tag_name" {
    type = string
    default = "infra-tf-state"
  
}