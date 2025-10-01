variable "eks_cluster" {
  description = "Name of the EKS cluster where OpenTelemetry Demo will be deployed"
  type        = string
}

variable "alb_frontend_security_group_id" {
  description = "Security group ID for ALB frontend (restricts internet access)"
  type        = string
}

variable "alb_backend_security_group_id" {
  description = "Security group ID of the ALB backend (communicates with EKS nodes)"
  type        = string
}

variable "chart_version" {
  description = "Helm chart version for opentelemetry-helm/opentelemetry-demo"
  type        = string
}

variable "grafana_admin_password" {
  description = "Admin password for Grafana dashboard access"
  type        = string
  sensitive   = true
}

variable "namespace" {
  description = "Kubernetes namespace where OpenTelemetry Demo will be deployed"
  type        = string
  default     = "otel-demo"
}

variable "tags" {
  description = "A map of tags to assign to all AWS resources"
  type        = map(string)
  default     = {}
}