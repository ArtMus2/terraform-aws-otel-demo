locals {
  eks_cluster_name = "${var.project_name}-al2023"
  s3_endpoint      = "s3.${var.region}.amazonaws.com"
}