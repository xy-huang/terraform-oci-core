resource "oci_identity_tag_namespace" "operation_tags" {
  compartment_id = var.compartment_id
  description    = "A collection of operation tags."
  name           = "Operation-Tags"
  is_retired     = false
}

resource "oci_identity_tag_namespace" "resource_tags" {
  compartment_id = var.compartment_id
  description    = "A collection of resource-based tags like Name, Type, Region.."
  name           = "Resource-Tags"
  is_retired     = false
}

resource "oci_identity_tag" "createdby" {
  name             = "CreatedBy"
  description      = "created by manual or terraform"
  tag_namespace_id = oci_identity_tag_namespace.operation_tags.id
  is_cost_tracking = false
  is_retired       = false
  validator {
    validator_type = "ENUM"
    values = [
      "Manual",
      "Terraform"
    ]
  }
}

resource "oci_identity_tag" "terraformversion" {
  name             = "TerraformVersion"
  description      = "version of terraform"
  tag_namespace_id = oci_identity_tag_namespace.operation_tags.id
  is_cost_tracking = false
  is_retired       = false
}

resource "oci_identity_tag" "family" {
  name             = "Family"
  description      = "family of resource type"
  tag_namespace_id = oci_identity_tag_namespace.resource_tags.id
  is_cost_tracking = true
  is_retired       = false
}

resource "oci_identity_tag" "name" {
  name             = "Name"
  description      = "resource name"
  tag_namespace_id = oci_identity_tag_namespace.resource_tags.id
  is_cost_tracking = false
  is_retired       = false
}

resource "oci_identity_tag" "region" {
  name             = "Region"
  description      = "region"
  tag_namespace_id = oci_identity_tag_namespace.resource_tags.id
  is_cost_tracking = false
  is_retired       = false
  validator {
    validator_type = "ENUM"
    values         = local.region_list
  }
}

resource "oci_identity_tag" "type" {
  name             = "Type"
  description      = "individual resource type"
  tag_namespace_id = oci_identity_tag_namespace.resource_tags.id
  is_cost_tracking = true
  is_retired       = false
}