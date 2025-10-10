##############################################################################
# SSH Key Variables
##############################################################################

variable "prefix" {
  description = "A unique identifier for resources that is prepended to resources that are provisioned. Must begin with a lowercase letter and end with a lowercase letter or number. Must be 16 or fewer characters."
  type        = string

  validation {
    error_message = "Prefix must begin and end with a letter and contain only letters, numbers, and - characters."
    condition     = can(regex("^([A-z]|[a-z][-a-z0-9]*[a-z0-9])$", var.prefix))
  }
}

# variable "resource_group_id" {
#   description = "The resource group where the VPC to be created"
#   type        = string
# }


variable "tags" {
  description = "A list of resource tags to be added to resources"
  type        = list(string)
  default     = []
}

variable "ssh_key" {
  description = "SSH keys to use to provision a VSI. If `public_key` is not provided, the named key will be looked up from data. See https://cloud.ibm.com/docs/vpc?topic=vpc-ssh-keys."
  type = object({
      name              = string
      public_key        = optional(string)
      resource_group_id = optional(string)
    })
}

variable "create_ssh_key" {
  description = "Set as true to create a new ssh key with the provided public key, or set as false to use an existing ssh key"
  type = bool
  default = true
}

##############################################################################
