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

resource "oci_core_subnet" "clusterSubnet_1" {
  #Required
  availability_domain = data.oci_identity_availability_domain.ad.name
  cidr_block          = "10.0.20.0/24"
  compartment_id      = var.compartment_id
  vcn_id              = oci_core_vcn.tutorial_vcn.id

  # Provider code tries to maintain compatibility with old versions.
  security_list_ids = [oci_core_vcn.tutorial_vcn.default_security_list_id]
  display_name      = "SubNet1ForClusters"
  route_table_id    = oci_core_route_table.tutorial_route_table.id
}

resource "oci_core_subnet" "clusterSubnet_2" {
  #Required
  availability_domain = data.oci_identity_availability_domain.ad.name
  cidr_block          = "10.0.21.0/24"
  compartment_id      = var.compartment_id
  vcn_id              = oci_core_vcn.tutorial_vcn.id
  display_name        = "SubNet1ForClusters"

  # Provider code tries to maintain compatibility with old versions.
  security_list_ids = [oci_core_vcn.tutorial_vcn.default_security_list_id]
  route_table_id    = oci_core_route_table.tutorial_route_table.id
}

resource "oci_core_subnet" "cluster_regional_subnet" {
  #Required
  cidr_block     = "10.0.26.0/24"
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.tutorial_vcn.id

  # Provider code tries to maintain compatibility with old versions.
  security_list_ids = [oci_core_vcn.tutorial_vcn.default_security_list_id]
  display_name      = "clusterRegionalSubnet"
  route_table_id    = oci_core_route_table.tutorial_route_table.id
}

resource "oci_core_subnet" "node_pool_regional_subnet_1" {
  #Required
  cidr_block     = "10.0.24.0/24"
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.tutorial_vcn.id

  # Provider code tries to maintain compatibility with old versions.
  security_list_ids = [oci_core_vcn.tutorial_vcn.default_security_list_id]
  display_name      = "regionalSubnet1"
  route_table_id    = oci_core_route_table.tutorial_route_table.id
}

resource "oci_core_subnet" "node_pool_regional_subnet_2" {
  #Required
  cidr_block     = "10.0.25.0/24"
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.tutorial_vcn.id

  # Provider code tries to maintain compatibility with old versions.
  security_list_ids = [oci_core_vcn.tutorial_vcn.default_security_list_id]
  display_name      = "regionalSubnet2"
  route_table_id    = oci_core_route_table.tutorial_route_table.id
}