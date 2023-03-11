data "oci_secrets_secretbundle" "bundle" {
  secret_id = var.secret_ocid
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
}
