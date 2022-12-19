resource "oci_core_vcn" "oke-tutorial-vcn" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment_id
}

resource "oci_core_internet_gateway" "oke-tutorial-internet-gateway" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.oke-tutorial-vcn.id
  enabled        = true
}

resource "oci_core_nat_gateway" "oke-tutorial-nat-gateway" {
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.oke-tutorial-vcn.id

    display_name = var.nat_gateway_display_name
    route_table_id = oci_core_route_table.oke-tutorial-private-route-table.id
}

resource "oci_core_default_route_table" "default_route_table" {
  manage_default_resource_id = oci_core_vcn.oke-tutorial-vcn.default_route_table_id
  display_name               = "DefaultRouteTable"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.oke-tutorial-internet-gateway.id
  }
}

resource "oci_core_route_table" "oke-tutorial-public-route-table" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.oke-tutorial-vcn.id

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.oke-tutorial-internet-gateway.id
  }
}

resource "oci_core_route_table" "oke-tutorial-private-route-table" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.oke-tutorial-vcn.id

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.oke-tutorial-nat-gateway.id
  }
}


# public
resource "oci_core_subnet" "oke-tutorial-k8s-api-endpoint-subnet" {
  cidr_block        = "10.0.0.0/28"
  compartment_id    = var.compartment_id
  vcn_id            = oci_core_vcn.oke-tutorial-vcn.id
  security_list_ids = [oci_core_security_list.oke-tutorial-k8s-api-endpoint-security-list.id]
  route_table_id    = oci_core_vcn.oke-tutorial-vcn.default_route_table_id
}

# private
resource "oci_core_subnet" "oke-tutorial-node-subnet" {
  cidr_block        = "10.0.10.0/24"
  compartment_id    = var.compartment_id
  vcn_id            = oci_core_vcn.oke-tutorial-vcn.id
  security_list_ids = [oci_core_security_list.oke-tutorial-node-security-list.id]
  route_table_id    = oci_core_vcn.oke-tutorial-vcn.default_route_table_id
}

# public
resource "oci_core_subnet" "oke-tutorial-service-subnet" {
  cidr_block        = "10.0.20.0/24"
  compartment_id    = var.compartment_id
  vcn_id            = oci_core_vcn.oke-tutorial-vcn.id
  security_list_ids = [oci_core_security_list.oke-tutorial-service-security-list.id]
  route_table_id    = oci_core_vcn.oke-tutorial-vcn.default_route_table_id
}

resource "oci_core_security_list" "oke-tutorial-k8s-api-endpoint-security-list" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.oke-tutorial-vcn.id

  egress_security_rules {
    destination = "0.0.0.0/0" # All services in specific region.
    protocol    = "17"        // udp
  }
  egress_security_rules {
    destination = "10.0.10.0/24"
    protocol    = "6" # tcp
  }
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "1"
  }

  ingress_security_rules {
    protocol = "6" # tcp
    source   = "0.0.0.0/0"
    tcp_options {
      max = "6443"
      min = "6443"
    }
  }
  ingress_security_rules {
    protocol = "6" # tcp
    source   = "10.0.10.0/24"
    tcp_options {
      max = "6443"
      min = "6443"
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "10.0.10.0/24"
  }
  ingress_security_rules {
    protocol = "1" # icmp
    source   = "10.0.10.0/24"
  }
}

resource "oci_core_security_list" "oke-tutorial-node-security-list" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.oke-tutorial-vcn.id

  egress_security_rules {
    destination = "0.0.0.0/0" # All services in specific region.
    protocol    = "6"
    tcp_options {
      max = "443"
      min = "443"
    }
  }
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6" // tcp
  }
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "1"
  }

  ingress_security_rules {
    protocol = "6" # tcp
    source   = "0.0.0.0/0"
    tcp_options {
      max = "6443"
      min = "6443"
    }
  }
  ingress_security_rules {
    protocol = "6" # tcp
    source   = "10.0.10.0/24"
    tcp_options {
      max = "6443"
      min = "6443"
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "10.0.10.0/24"
    tcp_options {
      max = "12250"
      min = "12250"
    }
  }
  ingress_security_rules {
    protocol = "1" # icmp
    source   = "10.0.10.0/24"
  }
}

resource "oci_core_security_list" "oke-tutorial-service-security-list" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.oke-tutorial-vcn.id

  egress_security_rules {
    destination = "10.0.10.0/24"
    protocol    = "6"
    tcp_options {
      max = "10256"
      min = "10256"
    }
  }
  egress_security_rules {
    destination = "10.0.10.0/24"
    protocol    = "6"
    tcp_options {
      max = "31078"
      min = "31078"
    }
  }
  egress_security_rules {
    destination = "10.0.10.0/24"
    protocol    = "6"
    tcp_options {
      max = "32734"
      min = "32734"
    }
  }
  egress_security_rules {
    destination = "10.0.10.0/24"
    protocol    = "6"
    tcp_options {
      max = "31346"
      min = "31346"
    }
  }
  egress_security_rules {
    destination = "10.0.10.0/24"
    protocol    = "6"
    tcp_options {
      max = "30805"
      min = "30805"
    }
  }
  egress_security_rules {
    destination = "10.0.10.0/24"
    protocol    = "6"
    tcp_options {
      max = "30656"
      min = "30656"
    }
  }
  egress_security_rules {
    destination = "10.0.10.0/24"
    protocol    = "6"
    tcp_options {
      max = "31480"
      min = "31480"
    }
  }
  egress_security_rules {
    destination = "10.0.10.0/24"
    protocol    = "6"
    tcp_options {
      max = "30572"
      min = "30572"
    }
  }
  egress_security_rules {
    destination = "10.0.10.0/24"
    protocol    = "6"
    tcp_options {
      max = "30350"
      min = "30350"
    }
  }
  egress_security_rules {
    destination = "10.0.10.0/24"
    protocol    = "6"
    tcp_options {
      max = "32411"
      min = "32411"
    }
  }
  egress_security_rules {
    destination = "10.0.10.0/24"
    protocol    = "6"
    tcp_options {
      max = "30978"
      min = "30978"
    }
  }
  egress_security_rules {
    destination = "10.0.10.0/24"
    protocol    = "6"
    tcp_options {
      max = "32571"
      min = "32571"
    }
  }
  egress_security_rules {
    destination = "10.0.10.0/24"
    protocol    = "6"
    tcp_options {
      max = "31508"
      min = "31508"
    }
  }

  ingress_security_rules {
    protocol = "6" # tcp
    source   = "0.0.0.0/0"
    tcp_options {
      max = "6443"
      min = "6443"
    }
  }
  ingress_security_rules {
    protocol = "6" # tcp
    source   = "0.0.0.0/0"
    tcp_options {
      max = "443"
      min = "443"
    }
  }
  ingress_security_rules {
    protocol = "6" # tcp
    source   = "0.0.0.0/0"
    tcp_options {
      max = "80"
      min = "80"
    }
  }
  ingress_security_rules {
    protocol = "6" # tcp
    source   = "0.0.0.0/0"
    tcp_options {
      max = "15021"
      min = "15021"
    }
  }
  ingress_security_rules {
    protocol = "6" # tcp
    source   = "0.0.0.0/0"
    tcp_options {
      max = "31400"
      min = "31400"
    }
  }
  ingress_security_rules {
    protocol = "6" # tcp
    source   = "0.0.0.0/0"
    tcp_options {
      max = "15443"
      min = "15443"
    }
  }
}

