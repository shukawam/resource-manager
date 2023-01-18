variable "compartment_id" {
  description = "compartment ocid"
}
variable "region" {
  description = "oci region(e.g. ap-tokyo-1, etc.)"
}

variable "availability_domain_name" {
  default     = ""
  description = "Availability Domain name, if non-empty takes precedence over availability_domain_number"
}

variable "availability_domain_number" {
  default = 1
}

variable "cluster_name" {
  default = "tfTestCluster"
}

variable "cluster_options_add_ons_is_kubernetes_dashboard_enabled" {
  default = false
}

variable "cluster_options_add_ons_is_tiller_enabled" {
  default = false
}

variable "cluster_options_kubernetes_network_config_pods_cidr" {
  default = "10.1.0.0/16"
}

variable "cluster_options_kubernetes_network_config_services_cidr" {
  default = "10.2.0.0/16"
}

variable "node_pool_initial_node_labels_key" {
  default = "managedBy"
}

variable "node_pool_initial_node_labels_value" {
  default = "ResourceManager"
}

variable "node_pool_name" {
  default = "tfPool"
}

variable "node_pool_node_image_name" {
  default = "Oracle-Linux-7.9"
}

variable "node_pool_node_shape" {
  default = "VM.Standard2.1"
}

variable "node_pool_quantity_per_subnet" {
  default = 1
}

variable "node_pool_ssh_public_key" {
  
}

variable "node_pool_boot_volume_size_in_gbs" {
  default = "50"
}
