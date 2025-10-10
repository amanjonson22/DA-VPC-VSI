output "ssh_key_id" {
  description = "The ID of the SSH Key found or created"
  value = local.ssh_key_id
}

output "ssh_key_name" {
  description = "The name of the ssh key created"
  value = local.ssh_key_name
}
