module "namespaces" {
  source = "../namespace"  
  namespace_names = var.namespace_names
}



module "ingres-nginx" {
  source = "../ingress-nginx" 
  
}

# module "traefik" {
#   source = "../traefik"  
# }

module "grafana" {
  source = "../grafana"  
}

module "apache" {
  source = "../apache"  
  service_type = "ClusterIP"
  replica_count = 2

}
