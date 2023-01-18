locals {
  availability_domain = (var.availability_domain_name != "" ? var.availability_domain_name : data.oci_identity_availability_domain.ad.name)
}

locals {
  all_images          = data.oci_core_images.shape_specific_images.images
  all_sources         = data.oci_containerengine_node_pool_option.tutorial_node_pool_option.sources
  compartment_images  = [for image in local.all_images : image.id if length(regexall("Oracle-Linux-7.9-20[0-9]*", image.display_name)) > 0]
  oracle_linux_images = [for source in local.all_sources : source.image_id if length(regexall("Oracle-Linux-7.9-20[0-9]*", source.source_name)) > 0]
  image_id            = tolist(setintersection(toset(local.compartment_images), toset(local.oracle_linux_images)))[0]
}
