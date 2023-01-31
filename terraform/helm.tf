locals {
  secrets = flatten([
    for chart, values in var.helm_charts : [
      for secret in lookup(values, "extra_secrets", []) : "${chart}-${secret}"
    ]
  ])
}

resource "random_password" "generated_secrets" {
  for_each = toset(local.secrets)
  length   = 20
  special  = false
}

resource "helm_release" "target" {
  for_each         = var.helm_charts
  name             = each.key
  repository       = each.value.repo
  chart            = each.value.chart
  namespace        = lookup(each.value, "namespace", "default")
  version          = lookup(each.value, "version", null)
  create_namespace = lookup(each.value, "create_namespace", true)
  values           = fileexists("${path.module}/values/${each.key}.yaml") ? [file("${path.module}/values/${each.key}.yaml")] : null

  dynamic "set" {
    for_each = lookup(each.value, "extra_secrets", [])
    content {
      name  = set.value
      value = random_password.generated_secrets["${each.key}-${set.value}"].result
    }
  }

  dynamic "set" {
    for_each = lookup(each.value, "extra_vars", {})
    content {
      name  = set.key
      value = set.value
    }
  }
}

