### Compartilháveis

variable "resource_group_id" {
  description = "The resource group where the VPC to be created"
  type        = string
}

variable "tags" {
  description = "The tags to be used on VNI and VSI"
  type        = list(string)
  default     = []
}

### Virtual Network Interface

variable "vni_name" {
  description = "Name for the Virtual Network Interface"
  type        = string
}

variable "vni_subnet" {
  description = "The subnet ID for the Virtual Network Interface"
  type        = string
}

### Image

variable "image_name" {
  description = "The name of the image to be used on the VSI. The default is CentOS Stream 10 AMD 64"
  type        = string
  default     = "ibm-centos-stream-10-amd64-4"
}

## VSI

variable "vsi_name" {
  description = "The name for the VSI"
  type        = string
}

variable "zone" {
  description = "The zone where the VSI will be, must be the same as the subnet the VSI will be on"
  type        = string
  default     = "br-sao-1"
}

variable "vsi_vpc_id" {
  description = "The ID of the VPC that the VSI is on"
  type        = string
}

variable "ssh_keys" {
  description = "The ID of the ssh keys that the VSI will be accessed with"
  type        = list(string)
}

variable "vsi_profile" {
  description = "The profile of the machine type of the VSI. The default is bx2-2x8"
  type        = string
  default     = "bx2-2x8"
}