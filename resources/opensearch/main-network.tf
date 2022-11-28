resource "oci_core_vcn" "opensearch-vcn" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment_id
}

resource "oci_core_internet_gateway" "opensearch-internet-gateway" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.opensearch-vcn.id
  enabled        = true
}

resource "oci_core_default_route_table" "default_route_table" {
  manage_default_resource_id = oci_core_vcn.opensearch-vcn.default_route_table_id
  display_name               = "DefaultRouteTable"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.opensearch-internet-gateway.id
  }
}

resource "oci_core_subnet" "opensearch-subnet" {
  cidr_block        = "10.0.0.0/24"
  compartment_id    = var.compartment_id
  vcn_id            = oci_core_vcn.opensearch-vcn.id
  security_list_ids = [oci_core_security_list.opensearch-security-list.id]
  route_table_id      = oci_core_vcn.opensearch-vcn.default_route_table_id
}

resource "oci_core_security_list" "opensearch-security-list" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.opensearch-vcn.id

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "17" // udp
    stateless   = true
  }
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "1"
    stateless   = true
  }

  ingress_security_rules {
    protocol  = "6" # tcp
    source    = "0.0.0.0/0"
    tcp_options {
      max = "22"
      min = "22"
    }
  }
  ingress_security_rules {
    protocol  = "1" # icmp
    source    = "0.0.0.0/0"
    stateless = true
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      max = var.security_list_ingress_security_rules_tcp_options_destination_port_api
      min = var.security_list_ingress_security_rules_tcp_options_destination_port_api
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      max = var.security_list_ingress_security_rules_tcp_options_destination_port_dashboard
      min = var.security_list_ingress_security_rules_tcp_options_destination_port_dashboard
    }
  }
}


resource "oci_core_route_table" "opensearch-route-table" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.opensearch-vcn.id
  
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.opensearch-internet-gateway.id
  }
}
