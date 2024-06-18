module "eks" {
  source = "git@github.com:selphjoe/infra-module.git//cloud-servers/aws/eks?ref=v0.3.0"
  cluster_name = "test-eks"
  coredns_version = "v1.9.3-eksbuild.15"
  kube_proxy_version = "v1.25.16-eksbuild.8"
  aws_ebs_csi_driver_version = "v1.16.0-eksbuild.1"
  vpc_cni_version = "v1.18.2-eksbuild.1"
  node_desired_size = 1
  node_max_size = 2
  node_min_size = 1
} 