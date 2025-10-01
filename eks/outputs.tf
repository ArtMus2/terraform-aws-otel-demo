output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = module.eks_managed_al2023.cluster_certificate_authority_data
}

output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.eks_managed_al2023.cluster_name
}

output "cluster_addons" {
  description = "Map of attribute maps for all EKS cluster addons enabled"
  value       = module.eks_managed_al2023.cluster_addons
}

output "cluster_endpoint" {
  description = "Endpoint for the Kubernetes API server"
  value       = module.eks_managed_al2023.cluster_endpoint
}

output "node_security_group_id" {
  description = "ID of the node shared security group"
  value       = module.eks_managed_al2023.node_security_group_id
}