resource "helm_release" "grafana" {
  chart      = "grafana"
  name       = "grafana"
  namespace  = "monitoring"
  repository = "https://grafana.github.io/helm-charts"
  version    = "7.0.6"
  values = [
    file("${path.module}/helm-chart-values/grafana.yaml")
  ]
}