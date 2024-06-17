variable "chart_version" {
  type    = string
  default = "4.8.3" 
  description = "this is the helm chart version "
}

variable "controller_image_tag" {
  type    = string
  default = "v1.4.0" 
  description = "this is the image version "
}

variable "controller_replica_count" {
  type    = number
  default = 2 
  description = "this is a replica count "
}

