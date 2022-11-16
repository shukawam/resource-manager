resource "oci_core_instance" "bastion_instance" {
  #Required
  #   availability_domain = var.instance_availability_domain
  #   compartment_id      = var.compartment_id
  #   shape               = var.instance_shape
  availability_domain = var.instance_availability_domain
  compartment_id      = var.compartment_id
  shape               = var.instance_shape

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }
}
