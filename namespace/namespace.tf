resource "kubernetes_namespace" "system_namespaces" {
  for_each = { for ns in var.system_namespaces : ns => ns }
  metadata {
    name = each.key
  }
}

resource "kubernetes_namespace" "namespace_names" {
  for_each = { for ns in var.namespace_names : ns => ns }
  metadata {
    name = each.key
  }
}