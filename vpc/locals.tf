locals {
  public_subnet_tags = {
    "kubernetes.io/role/elb"                   = "1"
    "kubernetes.io/cluster/${var.eks_cluster}" = "shared"
  }
  tags = merge(
    {
      Module     = "vpc"
      EksCluster = var.eks_cluster
      ManagedBy  = "terraform"
    },
    var.tags
  )
}