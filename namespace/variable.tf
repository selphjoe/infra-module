variable "system_namespaces" {
  type    = list(string)
  default = [
    "monitoring",
    "istio",
    "ingress-nginx",
    "cert-manager",
    "gitlab-agent",
    "apache"
    ]  # Add more namespaces as needed separated by commas
  description = "this namespace holds all the namespaces that is needed across all clusters. global namespaces"
}

variable "namespace_names" {
  type    = list(string)
  default = []  # Add more namespaces as needed separated by commas
  description = "this are namespaces that can be override in some clusters for example vault and jenkins in mgmt"
}