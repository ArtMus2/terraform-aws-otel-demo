<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 3.0.2 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.37 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 3.0.2 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.37 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.otel-demo-application](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace_v1.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_backend_security_group_id"></a> [alb\_backend\_security\_group\_id](#input\_alb\_backend\_security\_group\_id) | Security group ID of the ALB backend (communicates with EKS nodes) | `string` | n/a | yes |
| <a name="input_alb_frontend_security_group_id"></a> [alb\_frontend\_security\_group\_id](#input\_alb\_frontend\_security\_group\_id) | Security group ID for ALB frontend (restricts internet access) | `string` | n/a | yes |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Helm chart version for opentelemetry-helm/opentelemetry-demo | `string` | n/a | yes |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | Name of the EKS cluster where OpenTelemetry Demo will be deployed | `string` | n/a | yes |
| <a name="input_grafana_admin_password"></a> [grafana\_admin\_password](#input\_grafana\_admin\_password) | Admin password for Grafana dashboard access | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace where OpenTelemetry Demo will be deployed | `string` | `"otel-demo"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to all AWS resources | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->