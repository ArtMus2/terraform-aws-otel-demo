output "vpc_id" {
  description = "The ID of the AWS VPC"
  value       = module.vpc.vpc_id
  depends_on  = [module.vpc]
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
  depends_on  = [module.vpc]
}