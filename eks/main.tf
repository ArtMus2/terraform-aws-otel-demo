module "eks_managed_al2023" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.1.0"

  name                                     = var.eks_cluster
  kubernetes_version                       = var.kubernetes_version
  vpc_id                                   = var.vpc_id
  subnet_ids                               = var.subnet_ids
  endpoint_public_access                   = true
  enable_cluster_creator_admin_permissions = true

  enabled_log_types           = []
  create_cloudwatch_log_group = false
  create_kms_key              = false
  encryption_config           = null

  access_entries = var.enable_admin_access ? {
    cluster-admin = {
      kubernetes_groups = []
      principal_arn     = var.principal_arn

      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  } : {}

  addons = {
    aws-ebs-csi-driver = {}
    coredns            = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy = {}
    vpc-cni = {
      before_compute = true
    }
  }

  eks_managed_node_groups = {
    managed-node-group = {
      instance_types = var.node_instance_types
      capacity_type  = var.node_capacity_type
      ami_type       = "AL2023_x86_64_STANDARD"
      platform       = "al2023"

      min_size     = var.node_min_size
      max_size     = var.node_max_size
      desired_size = var.desired_node_size
    }
  }

  tags = var.tags
}