locals {
  tags = merge(
    {
      "Module" = "eks"
    },
    var.tags
  )
}
