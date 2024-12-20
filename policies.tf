resource "oci_identity_policy" "cli_operator_buckets_policy" {
  compartment_id = var.compartment_id
  description    = "cli_operator_buckets_policy"
  name           = "cli_operator_buckets_policy"
  statements = [
    "Allow group '${var.domain}'/'${var.group}' to manage buckets in tenancy where all {target.name!='${var.excluding_bucket}'}",
    "Allow group '${var.domain}'/'${var.group}' to read buckets in tenancy where all {target.name='${var.excluding_bucket}'}",
    "Allow group '${var.domain}'/'${var.group}' to manage objects in tenancy where all {target.bucket.name='${var.excluding_bucket}'}"
  ]
  defined_tags = merge(local.defined_tags, {
    "Resource-Tags.Family" = "Identity",
    "Resource-Tags.Name"   = "cli_operator_buckets_policy",
    "Resource-Tags.Type"   = "identity_policy"
  })
}

resource "oci_identity_policy" "cli_operator_core_services_policy" {
  compartment_id = var.compartment_id
  description    = "cli_operator_core_services_policy"
  name           = "cli_operator_core_services_policy"
  statements = [
    "Allow group '${var.domain}'/'${var.group}' to manage auto-scaling-configurations in tenancy",
    "Allow group '${var.domain}'/'${var.group}' to manage compute-capacity-reports in tenancy",
    "Allow group '${var.domain}'/'${var.group}' to manage compute-capacity-reservations in tenancy",
    "Allow group '${var.domain}'/'${var.group}' to manage compute-clusters in tenancy",
    "Allow group '${var.domain}'/'${var.group}' to manage compute-global-image-capability-schema in tenancy",
    "Allow group '${var.domain}'/'${var.group}' to manage compute-image-capability-schema in tenancy",
    "Allow group '${var.domain}'/'${var.group}' to manage compute-management-family in tenancy",
    "Allow group '${var.domain}'/'${var.group}' to manage dedicated-vm-hosts in tenancy",
    "Allow group '${var.domain}'/'${var.group}' to manage instance-agent-command-family in tenancy",
    "Allow group '${var.domain}'/'${var.group}' to manage instance-agent-commands in tenancy",
    "Allow group '${var.domain}'/'${var.group}' to manage instance-agent-family in tenancy",
    "Allow group '${var.domain}'/'${var.group}' to manage instance-family in tenancy",
    "Allow group '${var.domain}'/'${var.group}' to manage virtual-network-family in tenancy",
    "Allow group '${var.domain}'/'${var.group}' to manage volume-family in tenancy",
    "Allow group '${var.domain}'/'${var.group}' to manage work-requests in tenancy",
    "Allow group '${var.domain}'/'${var.group}' to manage tag-namespaces in tenancy",
  ]
  defined_tags = merge(local.defined_tags, {
    "Resource-Tags.Family" = "Identity",
    "Resource-Tags.Name"   = "cli_operator_core_services_policy",
    "Resource-Tags.Type"   = "identity_policy"
  })
}

resource "oci_identity_policy" "all_user_inspect_tag_namespaces" {
  compartment_id = var.compartment_id
  description    = "all_user_inspect_tag_namespaces"
  name           = "all_user_inspect_tag_namespaces"
  statements = [
    "allow any-user to inspect tag-namespaces in tenancy",
  ]
  defined_tags = merge(local.defined_tags, {
    "Resource-Tags.Family" = "Identity",
    "Resource-Tags.Name"   = "all_user_inspect_tag_namespaces",
    "Resource-Tags.Type"   = "identity_policy"
  })
}