output "cluster_kubernetes_versions" {
  value = [data.oci_containerengine_cluster_option.cluster_option.kubernetes_versions]
}

output "node_pool_kubernetes_version" {
  value = [data.oci_containerengine_node_pool_option.tutorial_node_pool_option.kubernetes_versions]
}
