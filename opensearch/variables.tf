variable "compartment_id" {}
variable "region" {}

resource "oci_core_vcn" "test_vcn" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment_id
}

resource "oci_core_subnet" "test_subnet" {
  cidr_block     = "10.0.0.0/24"
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.test_vcn.id
}

variable "opensearch_cluster_data_node_count" {
  default = 1
}

variable "opensearch_cluster_data_node_host_bare_metal_shape" {
  default = "dataNodeHostBareMetalShape"
}

variable "opensearch_cluster_data_node_host_memory_gb" {
  default = 10
}

variable "opensearch_cluster_data_node_host_ocpu_count" {
  default = 2
}

variable "opensearch_cluster_data_node_host_type" {
  default = "FLEX"
}

variable "opensearch_cluster_data_node_storage_gb" {
  default = 50
}

variable "opensearch_cluster_display_name" {
  default = "shukawam-dev-cluster"
}

variable "opensearch_cluster_freeform_tags" {
  default = { "bar-key" = "value" }
}

variable "opensearch_cluster_id" {
  default = "id"
}

variable "opensearch_cluster_master_node_count" {
  default = 1
}

variable "opensearch_cluster_master_node_host_bare_metal_shape" {
  default = "masterNodeHostBareMetalShape"
}

variable "opensearch_cluster_master_node_host_memory_gb" {
  default = 16
}

variable "opensearch_cluster_master_node_host_ocpu_count" {
  default = 1
}

variable "opensearch_cluster_master_node_host_type" {
  default = "FLEX"
}

variable "opensearch_cluster_opendashboard_node_count" {
  default = 1
}

variable "opensearch_cluster_opendashboard_node_host_memory_gb" {
  default = 10
}

variable "opensearch_cluster_opendashboard_node_host_ocpu_count" {
  default = 1
}

variable "opensearch_cluster_software_version" {
  default = "1.2.4"
}

variable "opensearch_cluster_state" {
  default = "ACTIVE"
}

variable "opensearch_cluster_system_tags" {
  default = {}
}
