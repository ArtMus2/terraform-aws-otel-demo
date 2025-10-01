# Terraform AWS OTel Demo
## Project Overview

The [OpenTelemetry Demo](https://opentelemetry.io/docs/demo/) serves as an introduction to observability for modern distributed systems by deploying a microservices application instrumented with the OpenTelemetry (OTel) protocol locally using Docker or Kubernetes.
**Terraform AWS OTel Demo** takes this deployment one step further by provisioning the demo application alongside Grafana's LGTM stack on AWS using Terraform.

## Architecture Overview
This project provisions a complete observability infrastructure on AWS consisting of:

### AWS Infrastructure

- **VPC** with public and private subnets across multiple availability zones
- **Application Load Balancer (ALB)** for ingress traffic management to Grafana
- **EKS cluster** for running observability backends and the OTel demo
- **S3 buckets** for persistent storage of telemetry data (logs, metrics, traces)

### Observability backends

- **Loki** - Log aggregation system
- **Tempo** - Distributed tracing backend
- **Mimir** - Long-term metrics storage

### Application

- **OpenTelemetry Demo** - Multi-service application including a Grafana installation, demonstrating observability best practices

The observability backends and the OTel demo are deployed via Helm charts in the EKS cluster, with the LGTM backends configured to use S3 for durable storage of telemetry data.

## Project structure

The root module consists of the following submodules with their Terraform documentation provided in their corresponding README:
- [EKS](./eks/)
- [Loki](./grafana_loki/)
- [Mimir](./grafana_mimir/)
- [Tempo](./grafana_tempo/)
- [AWS Application Load Balancer](./load_balancer/)
- [OTel Demo](./otel_demo/)
- [AWS VPC](./vpc/)

```
project/
├── locals.tf                       # Defines EKS cluster name
├── main.tf                         # Orchestrates all infrastructure modules
├── providers.tf                    # Configures AWS Kubernetes Helm providers
├── variables.tf                    # Input variables for root module
├── versions.tf                     # Terraform and provider version constraints
└── modules/
    ├── eks/
    │   ├── iam.tf                  # EKS Pod Identity
    │   ├── locals.tf               # AWS resource tags
    │   ├── main.tf                 # EKS cluster and managed node group
    │   ├── outputs.tf              # Cluster configurations needed by other submodules
    │   ├── README.md               # module usage documentation
    │   ├── variables.tf            # configuration input variables
    │   └── versions.tf             # module provider versions
    │
    ├── grafana_loki/
    │   ├── iam.tf                  # Pod Identity for S3 access
    │   ├── locals.tf               # bucket names
    │   ├── main.tf                 # Helm chart deployment and S3 bucket creation
    │   ├── README.md               # module usage documentation
    │   ├── values.yaml.tpl         # Helm chart configuration template
    │   ├── variables.tf            # deployment input variables
    │   └── versions.tf             # module provider versions
    │
    ├── grafana_mimir/
    │   ├── iam.tf                  # Pod Identity for S3 access
    │   ├── locals.tf               # bucket names
    │   ├── main.tf                 # Helm chart deployment and S3 bucket creation
    │   ├── README.md               # module usage documentation
    │   ├── values.yaml.tpl         # Helm chart configuration template
    │   ├── variables.tf            # deployment input variables
    │   └── versions.tf             # module provider versions
    │
    ├── grafana_tempo/
    │   ├── iam.tf                  # Pod Identity for S3 access
    │   ├── locals.tf               # bucket names
    │   ├── main.tf                 # Helm chart deployment and S3 bucket creation
    │   ├── README.md               # module usage documentation
    │   ├── values.yaml.tpl         # Helm chart configuration template
    │   ├── variables.tf            # deployment input variables
    │   └── versions.tf             # module provider versions
    │
    ├── load_balancer/
    │   ├── iam.tf                  # ALB controller Pod Identity
    │   ├── locals.tf               # ALB tags
    │   ├── main.tf                 # AWS Load Balancer Controller deployment
    │   ├── outputs.tf              # ALB security group IDs
    │   ├── README.md               # module documentation
    │   ├── variables.tf            # input variables
    │   └── versions.tf             # module versions
    │
    ├── otel_demo/
    │   ├── locals.tf               # OTel demo tags
    │   ├── main.tf                 # OpenTelemetry demo Helm deployment
    │   ├── README.md               # module documentation
    │   ├── values.yaml             # Helm values
    │   ├── variables.tf            # input variables
    │   └── versions.tf             # provider versions
    │
    └── vpc/
        ├── locals.tf               # subnet tag configurations
        ├── main.tf                 # vpc creation with NAT gateway
        ├── outputs.tf              # ID and private subnet IDs
        ├── README.md               # module usage documentation
        ├── variables.tf            # network input variables
        └── versions.tf             # module provider versions

```

## Prerequisites

- AWS Account with appropriate permissions
- Terraform >= 1.0
- AWS CLI configured
- kubectl (for cluster access post-deployment)

## Required Variables

- **'grafana_admin_password'** - Password for accessing Grafana as user 'admin'
- **'principal_arn'** - The Principal ARN for granting admin access to the EKS cluster
- **'allowed_ip'** - IP address or CIDR block allowed to access the deployment (see [Security Considerations](#security-considerations))

## Quick Start

```tfvars
vpc_cidr                = "10.0.0.0/16"
vpc_name                = "tf-aws-otel-demo-vpc"
region                  = "eu-central-1"
node_instance_types     = ["m5n.large", "m5.large", "m5a.large", "m4.large"]
project_name            = "tf-aws-otel-demo"
desired_node_size       = 4
node_min_size           = 4
node_max_size           = 5
enable_admin_access     = true
kubernetes_version      = "1.32"
tags = {
  Project    = "tf-aws-otel-demo"
}
```
As meantioned earlier 'grafana_admin_password', 'principal_arn' and 'allowed_ip' need to be also declared.

## Security Considerations
Access to the deployed application is controlled through an ALB ingress endpoint that restricts incoming traffic to a specific IP address or CIDR block. This IP-based access control provides basic protection but should be extended with further security measures, like deploying this project behind a Firewall. 


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 3.0.2 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.37 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | ./eks | n/a |
| <a name="module_grafana_loki"></a> [grafana\_loki](#module\_grafana\_loki) | ./grafana_loki | n/a |
| <a name="module_grafana_mimir"></a> [grafana\_mimir](#module\_grafana\_mimir) | ./grafana_mimir | n/a |
| <a name="module_grafana_tempo"></a> [grafana\_tempo](#module\_grafana\_tempo) | ./grafana_tempo | n/a |
| <a name="module_load_balancer"></a> [load\_balancer](#module\_load\_balancer) | ./load_balancer | n/a |
| <a name="module_otel_demo"></a> [otel\_demo](#module\_otel\_demo) | ./otel_demo | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./vpc | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_ip"></a> [allowed\_ip](#input\_allowed\_ip) | IP address or CIDR block allowed to access the load balancer | `string` | n/a | yes |
| <a name="input_azs"></a> [azs](#input\_azs) | List of availability zones to use (must be in the specified region) | `list(string)` | <pre>[<br/>  "eu-central-1a",<br/>  "eu-central-1b"<br/>]</pre> | no |
| <a name="input_desired_node_size"></a> [desired\_node\_size](#input\_desired\_node\_size) | Desired number of worker nodes in the node group | `number` | `3` | no |
| <a name="input_enable_admin_access"></a> [enable\_admin\_access](#input\_enable\_admin\_access) | Enable admin access entry for the EKS cluster | `bool` | `true` | no |
| <a name="input_grafana_admin_password"></a> [grafana\_admin\_password](#input\_grafana\_admin\_password) | Admin password for Grafana dashboard access | `string` | n/a | yes |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Kubernetes version for the EKS cluster | `string` | n/a | yes |
| <a name="input_loki_chart_version"></a> [loki\_chart\_version](#input\_loki\_chart\_version) | Helm chart version for grafana/loki | `string` | `"6.30.1"` | no |
| <a name="input_mimir_chart_version"></a> [mimir\_chart\_version](#input\_mimir\_chart\_version) | Helm chart version for grafana/mimir-distributed | `string` | `"5.8.0"` | no |
| <a name="input_node_capacity_type"></a> [node\_capacity\_type](#input\_node\_capacity\_type) | EC2 capacity type for EKS nodes (ON\_DEMAND or SPOT) | `string` | `"SPOT"` | no |
| <a name="input_node_instance_types"></a> [node\_instance\_types](#input\_node\_instance\_types) | EC2 instance types for EKS worker nodes | `list(string)` | n/a | yes |
| <a name="input_node_max_size"></a> [node\_max\_size](#input\_node\_max\_size) | Maximum number of worker nodes in the node group | `number` | `5` | no |
| <a name="input_node_min_size"></a> [node\_min\_size](#input\_node\_min\_size) | Minimum number of worker nodes in the node group | `number` | `3` | no |
| <a name="input_otel_demo_chart_version"></a> [otel\_demo\_chart\_version](#input\_otel\_demo\_chart\_version) | Helm chart version for opentelemetry-helm/opentelemetry-demo | `string` | `"0.37.0"` | no |
| <a name="input_principal_arn"></a> [principal\_arn](#input\_principal\_arn) | ARN of the principal to grant admin access to the EKS cluster | `string` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | List of private subnet CIDR blocks | `list(string)` | <pre>[<br/>  "10.0.16.0/20",<br/>  "10.0.48.0/20"<br/>]</pre> | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project used for resource naming and tagging | `string` | `"lgtm-otel-demo"` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | List of public subnet CIDR blocks | `list(string)` | <pre>[<br/>  "10.0.32.0/20",<br/>  "10.0.64.0/20"<br/>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region for all resources | `string` | `"eu-central-1"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to all AWS resources | `map(string)` | `{}` | no |
| <a name="input_tempo_chart_version"></a> [tempo\_chart\_version](#input\_tempo\_chart\_version) | Helm chart version for grafana/tempo | `string` | `"1.23.2"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the VPC | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## License
[Apache 2.0 License](./README.md)