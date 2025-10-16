
# data "ibm_resource_group" "rg" {
#   name = var.resource_group
# }

resource "ibm_is_ssh_key" "ssh_key" {
  count          = var.create_ssh_key ? 1 : 0
  name           = "${var.prefix}-${var.ssh_key.name}"
  public_key     = replace(var.ssh_key.public_key, "/==.*$/", "==")
  resource_group = var.resource_group_id
  tags           = var.tags
}

data "ibm_is_ssh_key" "existing_ssh_key" {
  count = !var.create_ssh_key ? 1 : 0
  name  = var.ssh_key.name
}

locals {
  ssh_key_name = var.create_ssh_key ? ibm_is_ssh_key.ssh_key[0].name : data.ibm_is_ssh_key.existing_ssh_key[0].name
  ssh_key_id   = var.create_ssh_key ? ibm_is_ssh_key.ssh_key[0].id : data.ibm_is_ssh_key.existing_ssh_key[0].id
}
