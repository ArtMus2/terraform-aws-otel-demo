resource "aws_s3_bucket" "mimir" {
  bucket = local.s3_bucket

  force_destroy = true

  tags = var.tags
}

resource "kubernetes_namespace_v1" "namespace" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "mimir-distributed" {
  name       = "mimir"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "mimir-distributed"
  version    = var.chart_version

  namespace = kubernetes_namespace_v1.namespace.metadata[0].name

  values = [
    templatefile("${path.module}/values.yaml.tpl", {
      bucket_name     = aws_s3_bucket.mimir.id
      region          = var.region
      endpoint        = var.s3_endpoint
      service_account = var.service_account
    })
  ]
}
