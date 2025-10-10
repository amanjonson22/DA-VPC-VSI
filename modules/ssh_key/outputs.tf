output "ssh_key_id" {
  description = "The ID of the SSH Key found or created"
  value = ibm_is_ssh_key.ssh_key.id
}

output "ssh_key_name" {
  description = "The name of the ssh key created"
  value = ibm_is_ssh_key.ssh_key.name
}

output "ssh_key_crn" {
  description = "The CRN of the SSH Key created"
  value = ibm_is_ssh_key.ssh_key.crn
}