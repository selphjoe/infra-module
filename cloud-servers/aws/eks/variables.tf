

variable "cluster_name" {
  type        = string
  description = "K8s name"
}

variable "region" {
  type    = string
  default = "eu-west-2"
}


variable "coredns_version" {
  type        = string
  description = "coredns version"
}

variable "kube_proxy_version" {
  type        = string
  description = "kubeproxy version"
}


variable "aws_ebs_csi_driver_version" {
  type        = string
  description = "aws-ebs-csi-driver version"
}

variable "vpc_cni_version" {
  type        = string
  description = "vpc_cni version"
}


variable "node_desired_size" {
  type        = number
  description = "node desired size"
}


variable "node_max_size" {
  type        = number
  description = "node max size"
}

variable "node_min_size" {
  type        = number
  description = "node min size"
}
