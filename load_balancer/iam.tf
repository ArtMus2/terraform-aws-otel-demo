module "aws_lb_controller_pod_identity" {
  source = "terraform-aws-modules/eks-pod-identity/aws"

  name = "aws-lbc"

  attach_aws_lb_controller_policy = true

  associations = {
    main-cluster = {
      cluster_name    = var.eks_cluster
      namespace       = "kube-system"
      service_account = var.service_account
    }
  }

  tags = local.tags
}
