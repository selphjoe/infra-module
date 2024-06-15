resource "helm_release" "nginx-test" {
  chart      = "nginx"
  name       = "nginx"
  namespace  = "test"
  repository = "https://charts.bitnami.com/bitnami"
  version    = "17.0.1"
  values = [
    file("${path.module}/helm-chart-values/nginx-values.yaml")
  ]
}