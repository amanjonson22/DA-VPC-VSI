####### Variáveis compartilhadas ######

variable "ibmcloud_api_key" {
  description = "The API key for IBM Cloud."
  type        = string
  sensitive   = true
}

# variable "resource_group" {
#   description = "The resource group where the VPC to be created"
#   type        = string
#   default     = "Default"
# }

variable "resource_group_id" {
  description = "The resource group where the VPC to be created"
  type        = string
  default     = "Default"
}

variable "tags" {
  description = "List of Tags for the resource created"
  type        = list(string)
  default     = null
}

###### Variáveis COS ######

variable "region" {
  description = "Region of the COS"
  type        = string
  default     = "br-sao"
}

variable "cos_instance_name" {
  description = "Name of the COS instance for the Flow Logs"
  type        = string
}

variable "cos_bucket_name" {
  description = "Bucket name for the Flow Logs"
  type        = string
}

###### Variáveis da VPC #######

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}


##### Variáveis da Subnet #######

variable "address_prefixes" {
  description = "Adress prefix for the VPC"
  type = list(object({
    name     = string
    location = string
    ip_range = string
  }))

  default = [
    {
      name     = "address-1"
      ip_range = "10.250.0.0/18"
      location = "br-sao-1"
    }
  ]
}


variable "subnet" {
  description = "Subnet configurations for the subnet, involving the location of the subnet and CIDR block"
  type = list(object({
    name            = string
    ipv4_cidr_block = string
    location        = string
  }))
  default = [{
    name            = "subnet-1"
    location        = "br-sao-1"
    ipv4_cidr_block = "10.250.0.0/24"
    }
  ]
}

#### VPC Flow Logs ######

variable "flow_logs_name" {
  description = "Name for the Flow Logs"
  type        = string
}

variable "flow_logs_active" {
  description = "If the Flow Logs will be active when creating it or not"
  type        = bool
  default     = true
}

variable "create_policy" {
  description = "Defines if the policy should be created or not. Should be true on the first appliance of this specific DA. Default is false."
  type        = bool
  default     = false
}

##### SSH Keys #####

variable "ssh_keys" {
  description = "SSH keys to use to provision a VSI. If `public_key` is not provided, the named key will be looked up from data. See https://cloud.ibm.com/docs/vpc?topic=vpc-ssh-keys."
  type = object({
    name              = string
    public_key        = optional(string)
    resource_group_id = optional(string)
  })
}

variable "create_ssh_key" {
  description = "Set as true to create a new ssh key with the provided public key, or set as false to use an existing ssh key. The default is true."
  type        = bool
  default     = false
}

#### Variáveis da VSI ######

variable "vni_name" {
  description = "Name for the Virtual Network Interface"
  type        = string
}

variable "vsi_name" {
  description = "The name for the VSI"
  type        = string
}

variable "vsi_profile" {
  description = "The profile of the machine type of the VSI. The default is bx2-2x8"
  type        = string
  default     = "bx2-2x8"
}

variable "vsi_image_name" {
  description = "The name of the image to be used on the VSI. The default is CentOS Stream 10 AMD 64"
  type        = string
  default     = "ibm-centos-stream-10-amd64-4"
}