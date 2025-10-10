resource "ibm_is_virtual_network_interface" "vni" {
  name           = var.vni_name
  subnet         = var.vni_subnet
  resource_group = var.resource_group_id
  tags           = var.tags
}

data "ibm_is_image" "image" {
  name = var.image_name
}


resource "ibm_is_instance" "vsi" {
  name    = var.vsi_name
  image   = data.ibm_is_image.image.id
  zone    = var.zone
  profile = var.vsi_profile
  primary_network_attachment {
    name = ibm_is_virtual_network_interface.vni.name
    virtual_network_interface {
      id = ibm_is_virtual_network_interface.vni.id
    }
  }
  vpc = var.vsi_vpc_id
  keys = var.ssh_keys

}

