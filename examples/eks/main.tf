module "eks" {
  source = "../../cloud-servers/aws/eks"
  cluster_name = var.cluster_name
  coredns_version = "v1.9.3-eksbuild.15"
  kube_proxy_version = "v1.26.15-eksbuild.5"
  aws_ebs_csi_driver_version = "v1.31.0-eksbuild.1"
  vpc_cni_version = "v1.18.2-eksbuild.1"
  node_desired_size = 1
  node_max_size = 2
  node_min_size = 1
}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name  # Assuming you have a module for EKS cluster
}

resource "null_resource" "update_kubeconfig" {
  provisioner "local-exec" {
    command = <<-EOT
      aws eks update-kubeconfig --name ${var.cluster_name} --region us-west-2
    EOT
  }
  depends_on = [module.eks]
}

module "namespace" {
  source = "../../namespace"  
  depends_on = [ null_resource.update_kubeconfig ]
}
