resource "aws_eks_addon" "coredns" {
  cluster_name  = var.cluster_name
  addon_name    = "coredns"
  addon_version = var.coredns_version
  depends_on    = [aws_eks_node_group.private-nodes]
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name      = var.cluster_name
  addon_name        = "kube-proxy"
  addon_version     = var.kube_proxy_version
  resolve_conflicts = "OVERWRITE"
  depends_on        = [aws_eks_node_group.private-nodes]

}


resource "aws_eks_addon" "aws_ebs_csi_driver" {
  cluster_name      = var.cluster_name
  addon_name        = "aws-ebs-csi-driver"
  addon_version     = var.aws_ebs_csi_driver_version
  resolve_conflicts = "OVERWRITE"
  depends_on        = [aws_eks_node_group.private-nodes]

}


resource "aws_eks_addon" "vpc_cni" {
  cluster_name      = var.cluster_name
  addon_name        = "vpc-cni"
  addon_version     = var.vpc_cni_version
  resolve_conflicts = "OVERWRITE"
  depends_on        = [aws_eks_node_group.private-nodes]

}

