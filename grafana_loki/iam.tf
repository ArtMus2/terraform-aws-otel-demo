data "aws_iam_policy_document" "loki_pod_assume_role" {
  statement {
    effect = "Allow"

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

data "aws_iam_policy_document" "loki_s3_access" {
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

resource "aws_iam_role" "loki_pod_identity" {
  name               = "loki-pod-identity-role"
  assume_role_policy = data.aws_iam_policy_document.loki_pod_assume_role.json

  tags = local.tags
}

resource "aws_iam_policy" "loki_s3_access" {
  name   = "loki-s3-access-policy"
  policy = data.aws_iam_policy_document.loki_s3_access.json

  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "loki_s3_access" {
  policy_arn = aws_iam_policy.loki_s3_access.arn
  role       = aws_iam_role.loki_pod_identity.name
}

resource "aws_eks_pod_identity_association" "loki" {
  cluster_name    = var.eks_cluster
  namespace       = kubernetes_namespace_v1.namespace.metadata[0].name
  service_account = var.service_account
  role_arn        = aws_iam_role.loki_pod_identity.arn
}