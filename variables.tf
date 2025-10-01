variable "region" {
  description = "AWS region for all resources"
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "Name of the project used for resource naming and tagging"
  type        = string
  default     = "lgtm-otel-demo"
}

variable "tags" {
  description = "A map of tags to assign to all AWS resources"
  type        = map(string)
  default     = {}
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "azs" {
  description = "List of availability zones to use (must be in the specified region)"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.32.0/20", "10.0.64.0/20"]
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.16.0/20", "10.0.48.0/20"]
}

variable "allowed_ip" {
  description = "IP address or CIDR block allowed to access the load balancer"
  type        = string
}

variable "principal_arn" {
  description = "ARN of the principal to grant admin access to the EKS cluster"
  type        = string
  sensitive   = true
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}

variable "enable_admin_access" {
  description = "Enable admin access entry for the EKS cluster"
  type        = bool
  default     = true
}

variable "node_instance_types" {
  description = "EC2 instance types for EKS worker nodes"
  type        = list(string)
}

variable "node_capacity_type" {
  description = "EC2 capacity type for EKS nodes (ON_DEMAND or SPOT)"
  type        = string
  default     = "SPOT"
  validation {
    condition     = contains(["ON_DEMAND", "SPOT"], var.node_capacity_type)
    error_message = "Capacity type must be ON_DEMAND or SPOT"
  }
}

variable "node_min_size" {
  description = "Minimum number of worker nodes in the node group"
  type        = number
  default     = 3
}

variable "node_max_size" {
  description = "Maximum number of worker nodes in the node group"
  type        = number
  default     = 5

  validation {
    condition     = var.node_max_size >= var.node_min_size
    error_message = "Max node size must be at least greater than node min size"
  }

  validation {
    condition     = var.node_max_size >= var.desired_node_size
    error_message = "Max node size must be at least greater than desired node size"
  }

  validation {
    condition     = var.node_max_size < 7
    error_message = "Maximum node count cannot exceed 6 to prevent excessive costs"
  }
}

variable "desired_node_size" {
  description = "Desired number of worker nodes in the node group"
  type        = number
  default     = 3
}

variable "loki_chart_version" {
  description = "Helm chart version for grafana/loki"
  type        = string
  default     = "6.30.1"
}

variable "mimir_chart_version" {
  description = "Helm chart version for grafana/mimir-distributed"
  type        = string
  default     = "5.8.0"
}

variable "tempo_chart_version" {
  description = "Helm chart version for grafana/tempo"
  type        = string
  default     = "1.23.2"
}

variable "otel_demo_chart_version" {
  description = "Helm chart version for opentelemetry-helm/opentelemetry-demo"
  type        = string
  default     = "0.37.0"
}

variable "grafana_admin_password" {
  description = "Admin password for Grafana dashboard access"
  type        = string
  sensitive   = true
}