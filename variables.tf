####### Variáveis compartilhadas ######

variable "ibmcloud_api_key" {
  description = "The API key for IBM Cloud."
  type        = string
  sensitive   = true
}

variable "resource_group" {
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

# variable "cos_instance_name" {
#   description = "Name of the COS instance for the Flow Logs"
#   type = string
# }

# variable "cos_bucket_name" {
#   description = "Bucket name for the Flow Logs"
#   type = string
# }

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
    },
    {
      name     = "address-2"
      ip_range = "10.250.64.0/18"
      location = "br-sao-2"
    },
    {
      name     = "address-3"
      ip_range = "10.250.128.0/18"
      location = "br-sao-3"
    }
 ]
}


variable "subnet" {
  description = "Subnet configurations for the subnet, involving the location of the subnet and CIDR block"
  type = list(object({
    name            = string
    location        = string
    ipv4_cidr_block = string
  }))
  default = [{
    name            = "subnet-1"
    location        = "br-sao-1"
    ipv4_cidr_block = "10.250.0.0/24"
    },
    {
      name            = "subnet-2"
      location        = "br-sao-2"
      ipv4_cidr_block = "10.250.64.0/24"
    },
    {
      name            = "subnet-3"
      location        = "br-sao-3"
      ipv4_cidr_block = "10.250.128.0/24"
    }
  ]
}

#### VPC Flow Logs ######

# variable "enable_vpc_flow_logs" {
#   description = "Flag to enable vpc flow logs. If true, flow log collector will be created"
#   type        = bool
#   default     = true

#   validation {
#     condition = (
#       !var.enable_vpc_flow_logs ||
#       (
#         var.create_authorization_policy_vpc_to_cos
#         ? (var.existing_cos_instance_guid != null && var.existing_storage_bucket_name != null)
#         : (var.existing_storage_bucket_name != null)
#       )
#     )
#     error_message = "To enable VPC Flow Logs, provide COS Bucket name. If you're creating an authorization policy then also provide COS instance GUID."
#   }
# }

# variable "create_authorization_policy_vpc_to_cos" {
#   description = "Create authorisation policy for VPC to access COS. Set as false if authorization policy exists already"
#   type        = bool
#   default     = true
# }

# variable "existing_cos_instance_guid" {
#   description = "GUID of the COS instance to create Flow log collector"
#   type        = string
#   default     = null
# }

# variable "existing_storage_bucket_name" {
#   description = "Name of the COS bucket to collect VPC flow logs"
#   type        = string
#   default     = null
# }

# variable "is_flow_log_collector_active" {
#   description = "Indicates whether the collector is active. If false, this collector is created in inactive mode."
#   type        = bool
#   default     = true
# }