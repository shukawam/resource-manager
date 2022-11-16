resource "oci_core_instance" "bastion_instance" {
  availability_domain = var.instance_availability_domain
  compartment_id      = var.compartment_id
  shape               = var.instance_shape
  shape_config {
    memory_in_gbs = "6"
    ocpus         = "1"
  }

  display_name = var.instance_display_name
  create_vnic_details {
    assign_private_dns_record = "false"
    assign_public_ip          = "true"
    subnet_id                 = oci_core_subnet.opensearch-subnet.id
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }
}
