resource "oci_identity_tag_namespace" "tag_namespace" {
  compartment_id = var.compartment_id
  description    = "Namespace for adding labels"
  name           = var.tag_namespace_name
}

resource "oci_identity_tag" "identity_tag" {
    description = "Label tag used for adding labels"
    name = var.identity_tag_name
    tag_namespace_id = oci_identity_tag_namespace.tag_namespace.id
    is_cost_tracking = false
    is_retired = false
}

#--Take password from OCI Vault
data "oci_secrets_secretbundle" "bundle" {
  secret_id = var.admin_password
}

resource "oci_database_autonomous_database" "tf_adb" {
  compartment_id           = var.compartment_id
  cpu_core_count           = var.cpu_core_count
  data_storage_size_in_tbs = var.data_storage_size_in_tbs
  db_name                  = var.db_name
  #admin_password           = var.admin_password
  admin_password           = base64decode(data.oci_secrets_secretbundle.bundle.secret_bundle_content.0.content)
  db_version               = var.db_version
  db_workload              = var.db_workload
  display_name             = var.db_name
  is_free_tier             = var.is_free_tier
  license_model            = var.license_model
  freeform_tags            = var.freeform_tags
  defined_tags             = var.defined_tags
  #is_access_control_enabled = var.is_access_control_enabled
  whitelisted_ips           = var.whitelisted_ips
  
  depends_on = [
    oci_identity_tag.identity_tag
  ]
  
  lifecycle {
    ignore_changes = [
      defined_tags["Oracle-Tags.CreatedBy"],
      defined_tags["Oracle-Tags.CreatedOn"]
    ]
  }
}
