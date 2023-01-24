### VCN
resource "oci_core_vcn" "tutorial_vcn" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment_id
  display_name   = "TutorialVcn"
}

### Network Security Groups
resource "oci_core_network_security_group" "tutorial_nsg" {
  compartment_id = var.compartment_id
  display_name   = "NSG for OKE Tutorial"
  vcn_id         = oci_core_vcn.tutorial_vcn.id
}

### Gateways

resource "oci_core_internet_gateway" "tutorial_igw" {
  compartment_id = var.compartment_id
  display_name   = "Internet Gateway for OKE Tutorial"
  vcn_id         = oci_core_vcn.tutorial_vcn.id
}

resource "oci_core_nat_gateway" "tutorial_ngw" {
  compartment_id = var.compartment_id
  display_name   = "Nat Gateway for OKE Tutorial"
  vcn_id         = oci_core_vcn.tutorial_vcn.id
}

### Route Tables

resource "oci_core_route_table" "tutorial_public_route_table" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.tutorial_vcn.id
  display_name   = "Tutorial Public Route Table"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.tutorial_igw.id
  }
}

resource "oci_core_route_table" "tutorial_private_route_table" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.tutorial_vcn.id
  display_name   = "TutorialRouteTable"

  route_rules {
    destination       = var.services_network
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.tutorial_ngw.id
  }

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.tutorial_ngw.id
  }
}

### Security Lists

resource "oci_core_security_list" "k8s_api_endpoint_security_list" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.tutorial_vcn.id
  display_name   = "K8s Endpoint Security List"

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"

    tcp_options {
      #Required
      max = "6443"
      min = "6443"
    }
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "10.0.10.0/24"

    tcp_options {
      #Required
      max = "6443"
      min = "6443"
    }
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "10.0.10.0/24"

    tcp_options {
      #Required
      max = "12250"
      min = "12250"
    }
  }

  ingress_security_rules {
    protocol = "1" # ICMP
    source   = "10.0.10.0/24"
    icmp_options {
      type = "3"
      code = "4"
    }
  }

  egress_security_rules {
    #Required
    destination = var.services_network
    description = "Allow Kubernetes Control Plane to communicate with OKE"
    protocol    = "6" # TCP
    tcp_options {
      max = "6443"
      min = "6443"
    }
  }
  egress_security_rules {
    destination = "10.0.10.0/24"
    description = "All traffic to worker nodes"
    protocol    = "6" # TCP
  }
  egress_security_rules {
    destination = "10.0.10.0/24"
    description = "Path discovery"
    protocol    = "1" # TCP
    icmp_options {
      type = "3"
      code = "4"
    }
  }

}

resource "oci_core_security_list" "node_pool_security_list" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.tutorial_vcn.id
  display_name   = "Node Pool Security List"

  ingress_security_rules {
    protocol = "all"
    source   = "10.0.10.0/24"
  }

  ingress_security_rules {
    protocol = "1" # ICMP
    source   = "10.0.0.0/28"
    icmp_options {
      type = "3"
      code = "4"
    }
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "10.0.0.0/28"
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"

    tcp_options {
      #Required
      max = "22"
      min = "22"
    }
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "10.0.20.0/24"

    tcp_options {
      #Required
      max = "30805"
      min = "30805"
    }
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "10.0.20.0/24"

    tcp_options {
      #Required
      max = "10256"
      min = "10256"
    }
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "10.0.20.0/24"

    tcp_options {
      #Required
      max = "31346"
      min = "31346"
    }
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "10.0.20.0/24"

    tcp_options {
      #Required
      max = "31078"
      min = "31078"
    }
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "10.0.20.0/24"

    tcp_options {
      #Required
      max = "32734"
      min = "32734"
    }
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "10.0.20.0/24"

    tcp_options {
      #Required
      max = "30656"
      min = "30656"
    }
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "10.0.20.0/24"

    tcp_options {
      #Required
      max = "31480"
      min = "31480"
    }
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "10.0.20.0/24"

    tcp_options {
      #Required
      max = "30572"
      min = "30572"
    }
  }

  egress_security_rules {
    #Required
    destination = "10.0.10.0/24"
    description = "Allow pods on one worker node to communicate with pods on other worker nodes"
    port        = "all"
  }

  egress_security_rules {
    #Required
    destination = "10.0.0.0/28"
    description = "Access to Kubernetes API Endpoint"
    protocol    = "6" # TCP
    tcp_options {
      max = "6443"
      min = "6443"
    }
  }

  egress_security_rules {
    #Required
    destination = "10.0.0.0/28"
    description = "Kubernetes worker to control plane communication"
    protocol    = "6" # TCP
    tcp_options {
      max = "12250"
      min = "12250"
    }
  }

  egress_security_rules {
    #Required
    destination = "10.0.0.0/28"
    description = "Path discovery"
    protocol    = "1" # ICMP
    icmp_options {
      type = "3"
      code = "4"
    }
  }

  egress_security_rules {
    #Required
    destination = var.services_network
    description = "	Allow nodes to communicate with OKE to ensure correct start-up and continued functioning"
    protocol    = "6" # TCP
    tcp_options {
      max = "443"
      min = "443"
    }
  }
  egress_security_rules {
    #Required
    destination = "0.0.0.0/0"
    description = "Worker Nodes access to Internet"
    protocol    = "6" # ICMP
  }

}

resource "oci_core_security_list" "lb_security_list" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.tutorial_vcn.id
  display_name   = "Load Balancer Security List"

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"
    tcp_options {
      #Required
      max = "443"
      min = "443"
    }
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"
    tcp_options {
      #Required
      max = "80"
      min = "80"
    }
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"
    tcp_options {
      #Required
      max = "15021"
      min = "15021"
    }
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"
    tcp_options {
      #Required
      max = "31400"
      min = "31400"
    }
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"
    tcp_options {
      #Required
      max = "15443"
      min = "15443"
    }
  }

  egress_security_rules {
    #Required
    destination = "10.0.10.0/24"
    protocol    = "6" # TCP
    tcp_options {
      max = "10256"
      min = "10256"
    }
  }

  egress_security_rules {
    #Required
    destination = "10.0.10.0/24"
    protocol    = "6" # TCP
    tcp_options {
      max = "31078"
      min = "31078"
    }
  }

  egress_security_rules {
    #Required
    destination = "10.0.10.0/24"
    protocol    = "6" # TCP
    tcp_options {
      max = "32734"
      min = "32734"
    }
  }
  egress_security_rules {
    #Required
    destination = "10.0.0.16/16"
    protocol    = "6" # TCP
    tcp_options {
      max = "10256"
      min = "10256"
    }
  }

  egress_security_rules {
    #Required
    destination = "10.0.10.0/24"
    protocol    = "6" # TCP
    tcp_options {
      max = "31346"
      min = "31346"
    }
  }
  egress_security_rules {
    #Required
    destination = "10.0.10.0/24"
    protocol    = "6" # TCP
    tcp_options {
      max = "30805"
      min = "30805"
    }
  }
}

### Subnets

resource "oci_core_subnet" "k8s_api_endpoint_regional_subnet" {
  #Required
  cidr_block     = "10.0.0.0/28"
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.tutorial_vcn.id

  # Provider code tries to maintain compatibility with old versions.
  security_list_ids = [oci_core_security_list.k8s_api_endpoint_security_list.id]
  display_name      = "oke-k8sApiEndpoint-subnet"
  route_table_id    = oci_core_route_table.tutorial_public_route_table.id
}

resource "oci_core_subnet" "node_pool_regional_subnet" {
  #Required
  cidr_block     = "10.0.10.0/24"
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.tutorial_vcn.id

  # Provider code tries to maintain compatibility with old versions.
  security_list_ids          = [oci_core_security_list.node_pool_security_list.id]
  display_name               = "oke-node-subnet"
  route_table_id             = oci_core_route_table.tutorial_public_route_table.id
  prohibit_public_ip_on_vnic = var.subnet_prohibit_public_ip_on_vnic
}

resource "oci_core_subnet" "lb_regional_subnet" {
  #Required
  cidr_block     = "10.0.20.0/24"
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.tutorial_vcn.id

  # Provider code tries to maintain compatibility with old versions.
  security_list_ids = [oci_core_security_list.lb_security_list.id]
  display_name      = "oke-svclb-subnet"
  route_table_id    = oci_core_route_table.tutorial_public_route_table.id
}
