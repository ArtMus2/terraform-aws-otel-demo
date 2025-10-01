module "vpc" {
  source = "./vpc"

  vpc_cidr        = var.vpc_cidr
  vpc_name        = var.vpc_name
  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  eks_cluster = local.eks_cluster_name

  tags = var.tags
}

module "eks" {
  source = "./eks"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  node_instance_types = var.node_instance_types
  node_capacity_type  = var.node_capacity_type
  node_min_size       = var.node_min_size
  node_max_size       = var.node_max_size
  desired_node_size   = var.desired_node_size

  enable_admin_access = true
  principal_arn       = var.principal_arn
  kubernetes_version  = var.kubernetes_version
  eks_cluster         = local.eks_cluster_name

  tags = var.tags
}

module "load_balancer" {
  source = "./load_balancer"

  vpc_id = module.vpc.vpc_id

  eks_addons             = module.eks.cluster_addons
  eks_cluster            = module.eks.cluster_name
  node_security_group_id = module.eks.node_security_group_id
  allowed_ip             = var.allowed_ip

  tags = var.tags
}

module "grafana_loki" {
  source = "./grafana_loki"

  region       = var.region
  s3_endpoint  = local.s3_endpoint
  project_name = var.project_name

  eks_cluster   = module.eks.cluster_name
  chart_version = var.loki_chart_version

  tags = var.tags

  depends_on = [module.load_balancer]
}

module "grafana_mimir" {
  source = "./grafana_mimir"

  region       = var.region
  s3_endpoint  = local.s3_endpoint
  project_name = var.project_name

  eks_cluster   = module.eks.cluster_name
  chart_version = var.mimir_chart_version

  tags = var.tags

  depends_on = [module.load_balancer]
}

module "grafana_tempo" {
  source = "./grafana_tempo"

  region       = var.region
  s3_endpoint  = local.s3_endpoint
  project_name = var.project_name

  eks_cluster   = module.eks.cluster_name
  chart_version = var.tempo_chart_version

  tags = var.tags

  depends_on = [module.load_balancer]
}

module "otel_demo" {
  source = "./otel_demo"

  alb_frontend_security_group_id = module.load_balancer.alb_frontend_security_group_id
  alb_backend_security_group_id  = module.load_balancer.alb_backend_security_group_id
  eks_cluster                    = module.eks.cluster_name

  chart_version          = var.otel_demo_chart_version
  grafana_admin_password = var.grafana_admin_password

  tags = var.tags

  depends_on = [module.load_balancer]
}