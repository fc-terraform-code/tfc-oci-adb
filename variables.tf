variable "compartment_id" { type = string }
variable "db_name"        { type = string }
variable "admin_password" { type = string }
variable "db_version"     { type = string }

# OLTP, DW, AJD, APEX
variable "db_workload"    { type = string }

# Must be false for AJD and APEX
variable "is_free_tier"   { type = string }

# BRING_YOUR_OWN_LICENSE or LICENSE_INCLUDED
variable "license_model"  { type = string }

variable "cpu_core_count" {
  type    = number
  default = 1
}

variable "data_storage_size_in_tbs" {
  type    = number
  default = 1
}

variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "private_key" {}
variable "compartment_ocid" {}
variable "region" {}
variable "fingerprint" {}

variable "freeform_tags" {
  type    = map
  default = {}
}
variable "defined_tags" {
  type    = map
  default = {}
}
variable "tag_namespace_name" {
  type    = string
  default = ""
}
variable "identity_tag_name" {
  type    = string
  default = ""
}

variable "is_mtls_connection_required" {
  type    = bool
  default = null
}
