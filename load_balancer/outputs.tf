output "alb_frontend_security_group_id" {
  description = "ID of the ALB frontend security group (restricts internet access)"
  value       = aws_security_group.alb_frontend.id
}

output "alb_backend_security_group_id" {
  description = "ID of the ALB backend security group (communicates with EKS nodes)"
  value       = aws_security_group.alb_backend.id
}