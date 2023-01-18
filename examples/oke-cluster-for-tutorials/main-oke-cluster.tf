resource "oci_containerengine_cluster" "tutorial_cluster" {
  #Required
  compartment_id     = var.compartment_id
  kubernetes_version = var.kubernetes_version
  name               = var.cluster_name
  vcn_id             = oci_core_vcn.tutorial_vcn.id

  #Optional
  endpoint_config {
    subnet_id            = oci_core_subnet.k8s_api_endpoint_regional_subnet.id
    is_public_ip_enabled = "true"
    nsg_ids              = [oci_core_network_security_group.tutorial_nsg.id]
  }

  options {
    service_lb_subnet_ids = [oci_core_subnet.lb_regional_subnet.id]

    #Optional
    add_ons {
      #Optional
      is_kubernetes_dashboard_enabled = var.cluster_options_add_ons_is_kubernetes_dashboard_enabled
      is_tiller_enabled               = var.cluster_options_add_ons_is_tiller_enabled
    }

    kubernetes_network_config {
      #Optional
      pods_cidr     = var.cluster_options_kubernetes_network_config_pods_cidr
      services_cidr = var.cluster_options_kubernetes_network_config_services_cidr
    }
  }
}

resource "oci_containerengine_node_pool" "tutorial_node_pool" {
  #Required
  cluster_id         = oci_containerengine_cluster.tutorial_cluster.id
  compartment_id     = var.compartment_id
  kubernetes_version = data.oci_containerengine_node_pool_option.tutorial_node_pool_option.kubernetes_versions[0]
  name               = var.node_pool_name
  node_shape         = var.node_pool_node_shape

  #Optional
  initial_node_labels {
    #Optional
    key   = var.node_pool_initial_node_labels_key
    value = var.node_pool_initial_node_labels_value
  }

  node_source_details {
    #Required
    image_id    = local.oracle_linux_images.0
    source_type = "IMAGE"

    #Optional
    boot_volume_size_in_gbs = var.node_pool_boot_volume_size_in_gbs
  }

  node_config_details {
    placement_configs {
      availability_domain = data.oci_identity_availability_domain.ad.name
      subnet_id           = oci_core_subnet.node_pool_regional_subnet.id
    }

    size = 3
  }
}

