variable "config_path" {
    type = string
    default = "~/.kube/config"
}

variable "config_context" {
    type = string
    default = "minikube-test"
}

variable "namespace_names" {
  type    = list(string)
  default = [
    "jenkins",
    "vault",
    "gitlab-runner",
    "argocd"
    ]  # Add more namespaces as needed separated by commas
  description = "this namespace holds specific namespaces for specific cluster"
}