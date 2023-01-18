resource "oci_core_vcn" "tutorial_vcn" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment_id
  display_name   = "tfVcnForClusters"
}

resource "oci_core_network_security_group" "tutorial_nsg" {
  compartment_id = var.compartment_id
  display_name   = "NSG for OKE Tutorial"
  vcn_id         = oci_core_vcn.tutorial_vcn.id
}

resource "oci_core_internet_gateway" "tutorial_igw" {
  compartment_id = var.compartment_id
  display_name   = "IGW for OKE Tutorial"
  vcn_id         = oci_core_vcn.tutorial_vcn.id
}

resource "oci_core_route_table" "tutorial_route_table" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.tutorial_vcn.id
  display_name   = "tfClustersRouteTable"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.tutorial_igw.id
  }
}

resource "oci_core_subnet" "k8s_api_endpoint_regional_subnet" {
  #Required
  cidr_block     = "10.0.0.0/28"
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.tutorial_vcn.id

  # Provider code tries to maintain compatibility with old versions.
  security_list_ids = [oci_core_vcn.tutorial_vcn.default_security_list_id]
  display_name      = "oke-k8sApiEndpoint-subnet"
  route_table_id    = oci_core_route_table.tutorial_route_table.id
}

resource "oci_core_subnet" "node_pool_regional_subnet" {
  #Required
  cidr_block     = "10.0.10.0/24"
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.tutorial_vcn.id

  # Provider code tries to maintain compatibility with old versions.
  security_list_ids      = [oci_core_vcn.tutorial_vcn.default_security_list_id]
  display_name           = "oke-node-subnet"
  route_table_id         = oci_core_route_table.tutorial_route_table.id
  prohibitPublicIpOnVnic = true
}

resource "oci_core_subnet" "lb_regional_subnet" {
  #Required
  cidr_block     = "10.0.20.0/24"
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.tutorial_vcn.id

  # Provider code tries to maintain compatibility with old versions.
  security_list_ids = [oci_core_vcn.tutorial_vcn.default_security_list_id]
  display_name      = "oke-svclb-subnet"
  route_table_id    = oci_core_route_table.tutorial_route_table.id
}
