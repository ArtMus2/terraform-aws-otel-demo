locals {
  s3_bucket = "${var.project_name}-tempo-traces"
  tags = merge(
    {
      Module     = "grafana_tempo"
      EksCluster = var.eks_cluster
      ManagedBy  = "terraform"
    },
    var.tags
  )
}
