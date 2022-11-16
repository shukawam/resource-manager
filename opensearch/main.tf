### Virtual Cloud Network
resource "oci_core_vcn" "opensearch-vcn" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment_id
}

resource "oci_core_subnet" "opensearch-subnet" {
  cidr_block     = "10.0.0.0/24"
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.opensearch-vcn.id
}

resource "oci_core_security_list" "opensearch-security-list" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.opensearch-vcn.id
  ingress_security_rules {
    protocol = var.security_list_ingress_security_rules_protocol
    source   = var.security_list_ingress_security_rules_source
    tcp_options {
      max = var.security_list_ingress_security_rules_tcp_options_destination_port_api
      min = var.security_list_ingress_security_rules_tcp_options_destination_port_api
    }
  }
  ingress_security_rules {
    protocol = var.security_list_ingress_security_rules_protocol
    source   = var.security_list_ingress_security_rules_source
    tcp_options {
      max = var.security_list_ingress_security_rules_tcp_options_destination_port_dashboard
      min = var.security_list_ingress_security_rules_tcp_options_destination_port_dashboard
    }
  }
}

### OpenSearch Bastion
resource "oci_core_instance" "opensearch_bastion" {
  #Required
  availability_domain = var.instance_availability_domain
  compartment_id      = var.compartment_id
  shape               = var.instance_shape

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }
}

### OpenSearch Cluster
resource "oci_opensearch_opensearch_cluster" "dev_opensearch_cluster" {
  compartment_id                     = var.compartment_id
  data_node_count                    = var.opensearch_cluster_data_node_count
  data_node_host_memory_gb           = var.opensearch_cluster_data_node_host_memory_gb
  data_node_host_ocpu_count          = var.opensearch_cluster_data_node_host_ocpu_count
  data_node_host_type                = var.opensearch_cluster_data_node_host_type
  data_node_storage_gb               = var.opensearch_cluster_data_node_storage_gb
  display_name                       = var.opensearch_cluster_display_name
  master_node_count                  = var.opensearch_cluster_master_node_count
  master_node_host_memory_gb         = var.opensearch_cluster_master_node_host_memory_gb
  master_node_host_ocpu_count        = var.opensearch_cluster_master_node_host_ocpu_count
  master_node_host_type              = var.opensearch_cluster_master_node_host_type
  opendashboard_node_count           = var.opensearch_cluster_opendashboard_node_count
  opendashboard_node_host_memory_gb  = var.opensearch_cluster_opendashboard_node_host_memory_gb
  opendashboard_node_host_ocpu_count = var.opensearch_cluster_opendashboard_node_host_ocpu_count
  software_version                   = var.opensearch_cluster_software_version
  subnet_compartment_id              = var.compartment_id
  subnet_id                          = oci_core_subnet.opensearch-subnet.id
  vcn_compartment_id                 = var.compartment_id
  vcn_id                             = oci_core_vcn.opensearch-vcn.id

  data_node_host_bare_metal_shape = var.opensearch_cluster_data_node_host_bare_metal_shape
  freeform_tags                   = var.opensearch_cluster_freeform_tags
}

data "oci_opensearch_opensearch_clusters" "test_opensearch_clusters" {
  compartment_id = var.compartment_id

  display_name = var.opensearch_cluster_display_name
}
