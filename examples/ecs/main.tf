module "eks" {
  source = "../../../cloud-servers/aws/ecs"
  # cluster_version = "1.25"
}


#  please add to module # access_config bootsrap
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster