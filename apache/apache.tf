resource "helm_release" "apache" {
  chart      = "apache"
  name       = "apache"
  namespace  = "apache"
  repository = "https://charts.bitnami.com/bitnami"
  version    = "10.9.2"
  values = [
    templatefile("${path.module}/helm-chart-values/apache.yaml",
      {
        service = {
          type = var.service_type

        }

        replicaCount = var.replica_count
      }
    )

  ]
}
