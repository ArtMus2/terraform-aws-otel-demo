locals {
  s3_bucket = "${var.project_name}-mimir-blocks"
  tags = merge(
    {
      Module     = "grafana_mimir"
      EksCluster = var.eks_cluster
      ManagedBy  = "terraform"
    },
    var.tags
  )
}
