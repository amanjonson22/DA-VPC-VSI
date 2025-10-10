#### Variáveis compartilhadas

variable "resource_group_id" {
  description = "The resource group ID where the Flow Logs and COS will be created"
  type        = string
}

#### Variáveis COS

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

#### Variáveis Flow Logs ####

variable "flow_logs_name" {
  description = "Name for the Flow Logs"
  type        = string
}

variable "flow_logs_active" {
  description = "Determine if the flow logs is active after creation. Set false to be inactive"
  type        = bool
  default     = true
}

variable "target" {
  description = "The ID of the target to collect the logs"
  type        = string
}

variable "tags" {
  description = "Tags for the Flow Logs"
  type        = list(string)
  default     = []
}