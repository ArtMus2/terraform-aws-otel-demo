data "aws_iam_policy_document" "mimir_pod_assume_role" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

data "aws_iam_policy_document" "mimir_s3_access" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject"
    ]

    resources = [
      "arn:aws:s3:::${local.s3_bucket}",
      "arn:aws:s3:::${local.s3_bucket}/*"
    ]
  }
}

resource "aws_iam_role" "mimir_pod_identity" {
  name               = "mimir-pod-identity-role"
  assume_role_policy = data.aws_iam_policy_document.mimir_pod_assume_role.json

  tags = local.tags
}

resource "aws_iam_policy" "mimir_s3_access" {
  name   = "mimir-s3-access-policy"
  policy = data.aws_iam_policy_document.mimir_s3_access.json

  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "mimir_s3_access" {
  policy_arn = aws_iam_policy.mimir_s3_access.arn
  role       = aws_iam_role.mimir_pod_identity.name
}

resource "aws_eks_pod_identity_association" "mimir" {
  cluster_name    = var.eks_cluster
  namespace       = kubernetes_namespace_v1.namespace.metadata[0].name
  service_account = var.service_account
  role_arn        = aws_iam_role.mimir_pod_identity.arn
}