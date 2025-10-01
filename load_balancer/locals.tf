locals {
  tags = merge(
    {
      Module     = "load_balancer"
      EksCluster = var.eks_cluster
      ManagedBy  = "terraform"
    },
    var.tags
  )
}
