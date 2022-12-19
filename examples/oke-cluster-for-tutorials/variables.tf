### commons
variable "compartment_id" {
  description = "compartment ocid"
}
variable "region" {
  description = "oci region(e.g. ap-tokyo-1, etc.)"
}
variable "availability_domain_name" {
  default     = ""
  description = "Availability Domain name, if non-empty takes precedence over availability_domain_number"
}
variable "availability_domain_number" {
  default     = 1
  description = "OCI Availability Domains: 1,2,3  (subject to region availability)"
}


### oke cluster for tutorials

### network
variable "nat_gateway_display_name" {
  default = "oke-tutorial-nat-gateway"
}