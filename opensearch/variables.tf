### commons
variable "compartment_id" {}
variable "region" {}

### compute
variable "instance_display_name" {
  default = "opensearch-bastion"
}
variable "instance_availability_domain" {
  default = "TGjA:PHX-AD-1"
}
variable "instance_shape" {
  default = "VM.Standard.A1.Flex"
}
variable "instance_shape_memory" {
  default = 6
}
variable "instance_shape_ocpus" {
  default = 1
}
variable "private_key_location" {
  description = "Your Private Key Location"
}
variable "ssh_public_key" {
  description = "SSH Public Key"
}
variable "instance_source_id" {
  default = "ocid1.image.oc1.phx.aaaaaaaahrywndmykfzoyeinsd7yvvyyianpgfvvazya55hy4ib2b7dnojxa"
}
variable "instance_source_type" {
  default = "image"
}

### network
variable "security_list_ingress_security_rules_tcp_options_destination_port_api" {
  default = 9200
}
variable "security_list_ingress_security_rules_tcp_options_destination_port_dashboard" {
  default = 5601
}

### OpenSearch Cluster
variable "opensearch_cluster_data_node_count" {
  default = 1
}
variable "opensearch_cluster_data_node_host_bare_metal_shape" {
  default = "dataNodeHostBareMetalShape"
}
variable "opensearch_cluster_data_node_host_memory_gb" {
  default = 20
}
variable "opensearch_cluster_data_node_host_ocpu_count" {
  default = 1
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
  default = { "ManagedByResourceManager" = "true" }
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
  default = 20
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
  default = 8
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
