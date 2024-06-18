module "eks" {
  source = "../../cloud-servers/aws/eks"
  cluster_version = "1.30"
  cluster_name = "test-eks"
  coredns_version = "v1.9.3-eksbuild.15"
  kube_proxy_version = "v1.26.15-eksbuild.5"
  aws_ebs_csi_driver_version = "v1.31.0-eksbuild.1"
  vpc_cni_version = "v1.18.2-eksbuild.1"
  node_desired_size = 1
  node_max_size = 2
  node_min_size = 1
}
