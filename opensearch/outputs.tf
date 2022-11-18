output "bastion_ip" {
  value = oci_core_instance.bastion_instance.public_ip
}

output "opendashboard_private_ip" {
    value = oci_opensearch_opensearch_cluster.dev_opensearch_cluster.opendashboard_private_ip
}

output "opensearch_private_ip" {
    value = oci_opensearch_opensearch_cluster.dev_opensearch_cluster.opensearch_private_ip
}

output "script" {
  value = "ssh -C -v -t -L 127.0.0.1:5601:${oci_opensearch_opensearch_cluster.dev_opensearch_cluster.opendashboard_private_ip}:5601 -L 127.0.0.1:9200:${oci_opensearch_opensearch_cluster.dev_opensearch_cluster.opensearch_private_ip}:9200 opc@${oci_core_instance.bastion_instance.public_ip} -i ${var.private_key_location}"
}