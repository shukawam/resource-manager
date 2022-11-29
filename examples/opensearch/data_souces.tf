data "oci_identity_availability_domain" "ad" {
  compartment_id = var.compartment_id
  ad_number      = var.availability_domain_number
}
