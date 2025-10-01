module "aws_ebs_csi_pod_identity" {
  source  = "terraform-aws-modules/eks-pod-identity/aws"
  version = "2.0.0"

  name = "aws-ebs-csi"

  attach_aws_ebs_csi_policy = true

  association_defaults = {
    namespace = "kube-system"
  }

  associations = {
    ebs-controller = {
      cluster_name    = module.eks_managed_al2023.cluster_name
      service_account = "ebs-csi-controller-sa"
    }
    ebs-node = {
      cluster_name    = module.eks_managed_al2023.cluster_name
      service_account = "ebs-csi-node-sa"
    }
  }

  tags = {
    Purpose = "EBS CSI Driver"
  }
}