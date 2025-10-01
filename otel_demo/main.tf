resource "kubernetes_namespace_v1" "namespace" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "otel-demo-application" {
  name       = "otel-demo-app"
  repository = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart      = "opentelemetry-demo"
  version    = var.chart_version

  namespace = kubernetes_namespace_v1.namespace.metadata[0].name

  values = [
    file("${path.module}/values.yaml"),
    yamlencode({
      components = {
        frontend-proxy = {
          ingress = {
            annotations = {
              "alb.ingress.kubernetes.io/security-groups" = "${var.alb_frontend_security_group_id},${var.alb_backend_security_group_id}"
            }
          }
        }
      }
    })
  ]

  set_sensitive = [
    {
      name  = "grafana.adminPassword"
      value = var.grafana_admin_password
    }
  ]
}