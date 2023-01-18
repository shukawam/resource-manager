variable "cluster_kube_config_expiration" {
  default = 2592000
}

variable "cluster_kube_config_token_version" {
  default = "2.0.0"
}

data "oci_containerengine_cluster_kube_config" "tutorial_cluster_kube_config" {
  #Required
  cluster_id = oci_containerengine_cluster.tutorial_cluster.id

  #Optional
  expiration    = var.cluster_kube_config_expiration
  token_version = var.cluster_kube_config_token_version
}

resource "local_file" "tutorial_cluster_kube_config_file" {
  content  = data.oci_containerengine_cluster_kube_config.tutorial_cluster_kube_config.content
  filename = "${path.module}/tutorial_cluster_kubeconfig"
}
