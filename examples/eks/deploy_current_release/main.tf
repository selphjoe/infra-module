module "eks" {
  source = "../../../cloud-servers/aws/eks"
  cluster_version = "1.25"
  cluster_name = "test-eks"
  coredns_version = "v1.9.3-eksbuild.15"
  kube_proxy_version = "v1.25.16-eksbuild.8"
  aws_ebs_csi_driver_version = "v1.16.0-eksbuild.1"
  vpc_cni_version = "v1.18.2-eksbuild.1"
  node_desired_size = 1
  node_max_size = 2
  node_min_size = 1

}

# module "namespace" {
#   source = "../../../namespace"
#   namespace_names = [ 
#     test,
#     test-demo
#   ]
#   depends_on = [ module.eks ]

# }

# module "nginx" {
#   source = "../../../nginx"
#   depends_on = [ module.namespace ]

# }

# how can i deploy the namespace and nginx helm release module into eks module "above after the ekse have been created in a single terraform apply
