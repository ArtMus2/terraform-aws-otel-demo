locals {
  s3_bucket = "${var.project_name}-loki-chunks"
  tags = merge(
    {
      Module     = "grafana_loki"
      EksCluster = var.eks_cluster
      ManagedBy  = "terraform"
    },
    var.tags
  )
}