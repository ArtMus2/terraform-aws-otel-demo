resource "aws_security_group" "alb_frontend" {
  name        = "${var.eks_cluster}-alb-frontend"
  description = "ALB frontend security group - restricts internet access to specific IP"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP access from specific IP only"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.allowed_ip}/32"]
  }

  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, {
    Name = "${var.eks_cluster}-alb-frontend"
  })
}

resource "aws_security_group" "alb_backend" {
  name        = "${var.eks_cluster}-alb-backend"
  description = "ALB backend security group - enables communication with EKS nodes"
  vpc_id      = var.vpc_id

  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, {
    Name = "${var.eks_cluster}-alb-backend"
  })
}

resource "aws_security_group_rule" "frontend_to_backend" {
  description              = "Allow ALB frontend to communicate with backend"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_frontend.id
  security_group_id        = aws_security_group.alb_backend.id
}

resource "aws_security_group_rule" "backend_to_eks_nodes" {
  description              = "Allow ALB backend to communicate with EKS worker nodes"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_backend.id
  security_group_id        = var.node_security_group_id
}

resource "helm_release" "aws-load-balancer-controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"

  values = [
    yamlencode({
      vpcId       = var.vpc_id
      clusterName = var.eks_cluster
      serviceAccount = {
        create = true
        name   = var.service_account
      }
      defaultTags = local.tags
    })
  ]

  depends_on = [
    var.eks_addons
  ]
}