data "oci_core_security_lists" "opensearch-security-lists" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.opensearch-vcn.id
}
