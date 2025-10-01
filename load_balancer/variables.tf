variable "vpc_id" {
  description = "ID of the VPC where load balancer resources will be created"
  type        = string
}

variable "eks_addons" {
  description = "EKS cluster addons configuration"
  type        = any
  default     = {}
}

variable "eks_cluster" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "node_security_group_id" {
  description = "Security group ID of the EKS worker nodes"
  type        = string
}

variable "allowed_ip" {
  description = "IP address or CIDR block allowed to access the load balancer"
  type        = string
}

variable "service_account" {
  description = "Service account name for the AWS Load Balancer Controller"
  type        = string
  default     = "alb-controller"
}

variable "tags" {
  description = "A map of tags to assign to all AWS resources"
  type        = map(string)
  default     = {}
}