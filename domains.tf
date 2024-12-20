resource "oci_identity_domain" "automation" {
  compartment_id     = var.compartment_id
  description        = var.domain
  display_name       = var.domain
  home_region        = var.region
  license_type       = "free"
  is_hidden_on_login = false
  defined_tags = merge(local.defined_tags, {
    "Resource-Tags.Family" = "Identity",
    "Resource-Tags.Name"   = var.domain,
    "Resource-Tags.Type"   = "identity_domain",
  })
  depends_on = [
    oci_identity_tag.terraformversion
  ]
}

resource "oci_identity_domains_group" "command_line_interface_operators" {
  display_name  = var.group
  idcs_endpoint = oci_identity_domain.automation.url
  schemas = [
    "urn:ietf:params:scim:schemas:core:2.0:Group",
    "urn:ietf:params:scim:schemas:oracle:idcs:extension:dynamic:Group",
    "urn:ietf:params:scim:schemas:oracle:idcs:extension:OCITags",
    "urn:ietf:params:scim:schemas:oracle:idcs:extension:group:Group"
  ]

  attribute_sets = ["all"]
  members {
    type  = "User"
    value = oci_identity_domains_user.terraform.id
  }
  urnietfparamsscimschemasoracleidcsextension_oci_tags {
    defined_tags {
      key       = "CreatedBy"
      namespace = "Operation-Tags"
      value     = "Terraform"
    }
    defined_tags {
      key       = "TerraformVersion"
      namespace = "Operation-Tags"
      value     = var.terraform_version
    }
    defined_tags {
      key       = "Region"
      namespace = "Resource-Tags"
      value     = var.region
    }
    defined_tags {
      key       = "Family"
      namespace = "Resource-Tags"
      value     = "Identity"
    }
    defined_tags {
      key       = "Name"
      namespace = "Resource-Tags"
      value     = var.group
    }
    defined_tags {
      key       = "Type"
      namespace = "Resource-Tags"
      value     = "identity_domains_group"
    }
  }
  urnietfparamsscimschemasoracleidcsextensiondynamic_group {
    membership_rule = ""
    membership_type = "static"
  }
  urnietfparamsscimschemasoracleidcsextensiongroup_group {
    description = "user in this group can execute oci-cli and terraform"
  }

  lifecycle {
    ignore_changes = [
      ## ignore tags changes to avoid data loss
      ## https://github.com/oracle/terraform-provider-oci/issues/2086

      urnietfparamsscimschemasoracleidcsextension_oci_tags
    ]
  }

  depends_on = [oci_identity_domains_user.terraform]
}

resource "oci_identity_domains_user" "terraform" {
  idcs_endpoint = oci_identity_domain.automation.url
  schemas = [
    "urn:ietf:params:scim:schemas:core:2.0:User",
    "urn:ietf:params:scim:schemas:oracle:idcs:extension:userState:User",
    "urn:ietf:params:scim:schemas:oracle:idcs:extension:OCITags",
    "urn:ietf:params:scim:schemas:oracle:idcs:extension:mfa:User",
    "urn:ietf:params:scim:schemas:oracle:idcs:extension:user:User"
  ]
  user_name    = var.user_name
  active       = true
  display_name = var.user_name
  emails {
    type      = "recovery"
    value     = var.user_recovery_email
    primary   = false
    secondary = false
    verified  = true
  }
  emails {
    type      = "work"
    value     = var.user_email
    primary   = true
    secondary = false
    verified  = true
  }
  name {
    family_name = var.user_name
    formatted   = var.user_name
  }
  urnietfparamsscimschemasoracleidcsextension_oci_tags {
    defined_tags {
      key       = "CreatedBy"
      namespace = "Operation-Tags"
      value     = "Terraform"
    }
    defined_tags {
      key       = "TerraformVersion"
      namespace = "Operation-Tags"
      value     = var.terraform_version
    }
    defined_tags {
      key       = "Region"
      namespace = "Resource-Tags"
      value     = var.region
    }
    defined_tags {
      key       = "Family"
      namespace = "Resource-Tags"
      value     = "Identity"
    }
    defined_tags {
      key       = "Name"
      namespace = var.user_name
      value     = var.group
    }
    defined_tags {
      key       = "Type"
      namespace = "Resource-Tags"
      value     = "identity_domains_user"
    }
  }
  urnietfparamsscimschemasoracleidcsextensioncapabilities_user {
    can_use_api_keys                 = true
    can_use_auth_tokens              = true
    can_use_console                  = false
    can_use_console_password         = true
    can_use_customer_secret_keys     = true
    can_use_db_credentials           = true
    can_use_oauth2client_credentials = true
    can_use_smtp_credentials         = true
  }
  lifecycle {
    ignore_changes = [
      ## ignore tags changes to avoid data loss
      ## https://github.com/oracle/terraform-provider-oci/issues/2086

      urnietfparamsscimschemasoracleidcsextension_oci_tags
    ]
  }
}