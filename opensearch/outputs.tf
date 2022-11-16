output "bastion_ip" {
  value = oci_core_instance.opensearch_bastion.public_ip
}

output "opendashboard_private_ip" {
    value = oci_opensearch_opensearch_cluster.dev_opensearch_cluster.opendashboard_private_ip
}

output "opensearch_private_ip" {
    value = oci_opensearch_opensearch_cluster.dev_opensearch_cluster.opensearch_private_ip
}