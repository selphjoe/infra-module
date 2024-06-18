locals {
  dummy_map = { "key1" = "value1" }
}

resource "aws_iam_role" "nodes" {
  name = "eks-node-group-nodes"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes.name
}

resource "aws_eks_node_group" "private-nodes" {
  cluster_name    = aws_eks_cluster.demo.name
  version         = var.cluster_version
  node_group_name = "private-nodes"
  node_role_arn   = aws_iam_role.nodes.arn

  subnet_ids = [
    aws_subnet.private-eu-west-2a.id,
    aws_subnet.private-eu-west-2b.id
  ]

  capacity_type  = "ON_DEMAND"
  instance_types = ["t3.small"]

  scaling_config {
    desired_size = var.node_desired_size
    max_size     = var.node_max_size
    min_size     = var.node_min_size
  }

  update_config {
    max_unavailable = 1
    # max_unavailable_percentage = 20
  }

  labels = {
    role = "general"
  }
  depends_on = [
    aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly,
  ]
}

# Null Resource to Drain Nodes
# resource "null_resource" "drain_nodes" {
#   for_each = data.aws_eks_cluster.demo.endpoint != "" ? { for k, v in local.dummy_map : k => v } : {}

#   triggers = {
#     node_group_version = aws_eks_node_group.private-nodes.version
#   }

#   provisioner "local-exec" {
#     command = <<EOT
#       if [ "$(kubectl get nodes -l role=general -o json | jq -r '.items[] | select(.spec.unschedulable != true) | .metadata.name')" != "" ]; then
#         kubectl get nodes -l role=general -o json | jq -r '.items[] | select(.spec.unschedulable != true) | .metadata.name' | while read node; do
#           kubectl drain $node --ignore-daemonsets --delete-emptydir-data --force --grace-period=120
#         done
#       fi
#     EOT
#   }

#   depends_on = [aws_eks_node_group.private-nodes]
# }

# # Data Source to Fetch Cluster Endpoint and Auth Data
# data "aws_eks_cluster" "demo" {
#   name = aws_eks_cluster.demo.name
# }

# data "aws_eks_cluster_auth" "demo" {
#   name = aws_eks_cluster.demo.name
# }



#   taint {
#     key    = "team"
#     value  = "devops"
#     effect = "NO_SCHEDULE"
#   }

# launch_template {
#   name    = aws_launch_template.eks-with-disks.name
#   version = aws_launch_template.eks-with-disks.latest_version
# }



# resource "aws_launch_template" "eks-with-disks" {
#   name = "eks-with-disks"

#   key_name = "local-provisioner"

#   block_device_mappings {
#     device_name = "/dev/xvdb"

#     ebs {

#       volume_size = 50
#       volume_type = "gp2"
# }
#   }
# }
