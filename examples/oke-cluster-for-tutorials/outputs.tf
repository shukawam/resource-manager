output "cluster_kubernetes_versions" {
  value = [data.oci_containerengine_cluster_option.cluster_option.kubernetes_versions]
}

output "node_pool_kubernetes_version" {
  value = [data.oci_containerengine_node_pool_option.tutorial_node_pool_option.kubernetes_versions]
}

output "cluster" {
  value = {
    id                 = oci_containerengine_cluster.tutorial_cluster.id
    kubernetes_version = oci_containerengine_cluster.tutorial_cluster.kubernetes_version
    name               = oci_containerengine_cluster.tutorial_cluster.name
  }
}

output "node_pool" {
  value = {
    id                 = oci_containerengine_node_pool.tutorial_node_pool.id
    kubernetes_version = oci_containerengine_node_pool.tutorial_node_pool.kubernetes_version
    name               = oci_containerengine_node_pool.tutorial_node_pool.name
  }
}
