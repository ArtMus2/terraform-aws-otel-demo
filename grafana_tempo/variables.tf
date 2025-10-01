variable "region" {
  description = "AWS region where resources are deployed"
  type        = string
}

variable "project_name" {
  description = "Name of the project (used for S3 bucket naming)"
  type        = string
}

variable "s3_endpoint" {
  description = "S3 endpoint URL for the specified region"
  type        = string
}

variable "eks_cluster" {
  description = "Name of the EKS cluster where Tempo will be deployed"
  type        = string
}

variable "chart_version" {
  description = "Helm chart version for grafana/tempo"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace where Tempo will be deployed"
  type        = string
  default     = "tempo"
}

variable "service_account" {
  description = "Kubernetes service account name for Tempo"
  type        = string
  default     = "tempo"
}

variable "tags" {
  description = "A map of tags to assign to all AWS resources"
  type        = map(string)
  default     = {}
}