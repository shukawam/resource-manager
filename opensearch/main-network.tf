resource "oci_core_vcn" "opensearch-vcn" {
  cidr_block     = var.vcn_cidr_block
  compartment_id = var.compartment_id
}

resource "oci_core_subnet" "opensearch-subnet" {
  cidr_block        = var.subnet_cidr_block
  compartment_id    = var.compartment_id
  vcn_id            = oci_core_vcn.opensearch-vcn.id
  security_list_ids = oci_core_security_lists.opensearch-security-lists.security_lists
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
