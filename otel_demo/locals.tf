locals {
  tags = merge(
    {
      Module     = "otel_demo"
      EksCluster = var.eks_cluster
      ManagedBy  = "terraform"
    },
    var.tags
  )
}
