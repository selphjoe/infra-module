resource "helm_release" "ingress-nginx" {
  chart      = "ingress-nginx"
  name       = "ingress-nginx"
  namespace  = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  version    = var.chart_version
  values = [
    templatefile("${path.module}/helm-chart-values/ingress-nginx.yaml",
      {
        controller = {
          image = {
            tags = var.controller_image_tag
          }
          replicas = var.controller_replica_count

        }
      }
          
    )
  ]
}