resource "ibm_is_ssh_key" "ssh_key" {
  name           = "${var.prefix}-${var.ssh_keys.name}"
  public_key     = replace(var.ssh_keys.public_key, "/==.*$/", "==")
  # resource_group = var.resource_group_id
  tags           = var.tags
}
