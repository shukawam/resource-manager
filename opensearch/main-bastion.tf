resource "oci_core_instance" "bastion_instance" {
  availability_domain = local.availability_domain
  compartment_id      = var.compartment_id
  shape               = var.instance_shape
  shape_config {
    memory_in_gbs = var.instance_shape_memory
    ocpus         = var.instance_shape_ocpus
  }
  source_details {
    source_id   = var.instance_source_id
    source_type = var.instance_source_type
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
  agent_config {
    is_management_disabled = "false"
    is_monitoring_disabled = "false"
    plugins_config {
      desired_state = "DISABLED"
      name          = "Vulnerability Scanning"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Oracle Java Management Service"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "OS Management Service Agent"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Management Agent"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Custom Logs Monitoring"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Compute Instance Run Command"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Compute Instance Monitoring"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Block Volume Management"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Bastion"
    }
  }
}
