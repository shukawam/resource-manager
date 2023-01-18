data "oci_identity_availability_domain" "ad" {
  compartment_id = var.compartment_id
  ad_number      = var.availability_domain_number
}

data "oci_containerengine_cluster_option" "cluster_option" {
  cluster_option_id = "all"
  compartment_id = var.compartment_id
}

data "oci_containerengine_node_pool_option" "tutorial_node_pool_option" {
  node_pool_option_id = "all"
  compartment_id = var.compartment_id
}

data "oci_core_images" "shape_specific_images" {
  #Required
  compartment_id = var.compartment_id
  shape          = "VM.Standard2.1"
}
