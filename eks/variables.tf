variable "vpc_id" {
  description = "ID of the VPC where EKS cluster will be created"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs where the EKS cluster and nodes will be provisioned"
  type        = list(string)
}

variable "node_instance_types" {
  description = "List of EC2 instance types for EKS worker nodes"
  type        = list(string)
}

variable "node_capacity_type" {
  description = "EC2 capacity type for nodes (ON_DEMAND or SPOT)"
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

variable "enable_admin_access" {
  description = "Enable admin access entry for the EKS cluster"
  type        = bool
  default     = false
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

variable "eks_cluster" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to all AWS resources"
  type        = map(string)
  default     = {}
}