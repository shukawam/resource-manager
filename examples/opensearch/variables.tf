### commons
variable "compartment_ocid" {
}
variable "region" {
}
variable "availability_domain_name" {
}


### compute
variable "instance_display_name" {
}
variable "instance_shape" {
}
variable "instance_shape_memory" {
}
variable "instance_shape_ocpus" {
}
variable "private_key_location" {
}
variable "ssh_public_key" {
}
variable "instance_source_id" {
}
variable "instance_source_type" {
}

### network
variable "security_list_ingress_security_rules_tcp_options_destination_port_api" {
}
variable "security_list_ingress_security_rules_tcp_options_destination_port_dashboard" {
}

### OpenSearch Cluster
variable "opensearch_cluster_data_node_count" {
}
variable "opensearch_cluster_data_node_host_bare_metal_shape" {
}
variable "opensearch_cluster_data_node_host_memory_gb" {
}
variable "opensearch_cluster_data_node_host_ocpu_count" {
}
variable "opensearch_cluster_data_node_host_type" {
}
variable "opensearch_cluster_data_node_storage_gb" {
}
variable "opensearch_cluster_display_name" {
}
variable "opensearch_cluster_freeform_tags" {
  default = { "ManagedByResourceManager" = "true" }
}
variable "opensearch_cluster_id" {
}
variable "opensearch_cluster_master_node_count" {
}
variable "opensearch_cluster_master_node_host_bare_metal_shape" {
}
variable "opensearch_cluster_master_node_host_memory_gb" {
}
variable "opensearch_cluster_master_node_host_ocpu_count" {
}
variable "opensearch_cluster_master_node_host_type" {
}
variable "opensearch_cluster_opendashboard_node_count" {
}
variable "opensearch_cluster_opendashboard_node_host_memory_gb" {
}
variable "opensearch_cluster_opendashboard_node_host_ocpu_count" {
}
variable "opensearch_cluster_software_version" {
}
variable "opensearch_cluster_state" {
}
variable "opensearch_cluster_system_tags" {
  default = {}
}
