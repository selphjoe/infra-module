# # resource "kubernetes_manifest" "prometheus_crds" {
# #   for_each = fileset("${path.module}/crds", "*.yaml")

# #   manifest = file("${path.module}/crds/${each.value}")
# # }

# resource "kubernetes_manifest" "prometheus_crds" {
#   for_each = fileset("${path.module}/crds", "*.yaml")

#   manifest = {
#     "apiVersion" = "apiextensions.k8s.io/v1"
#     "kind"       = "CustomResourceDefinition"
#     "metadata" = {
#       "name" = replace(each.value, ".yaml", "")
#     }
#     "spec" = yamldecode(file("${path.module}/crds/${each.value}"))
#   }
# }


resource "helm_release" "prometheus" {
  chart      = "prometheus"
  name       = "prometheus"
  namespace  = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"
  version    = "25.6.0"
  values = [
    file("${path.module}/helm-chart-values/prometheus.yaml")
  ]
  # depends_on = [ kubernetes_manifest.prometheus_crds ]
}

