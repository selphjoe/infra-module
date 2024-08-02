resource "helm_release" "jenkins" {
  chart      = "jenkins"
  name       = "jenkins"
  namespace  = "jenkins"
  repository = "https://charts.jenkins.io"
  version    = "5.5.1"
  values = [
    file("${path.module}/helm-chart-values/jenkins.yaml")
  ]
}