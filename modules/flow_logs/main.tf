resource "random_id" "random_id" {
  byte_length = 6
}

module "cos" {
  source                 = "terraform-ibm-modules/cos/ibm"
  version                = "10.4.0"
  resource_group_id      = var.resource_group_id
  cos_instance_name      = var.cos_instance_name
  bucket_name            = "${var.cos_bucket_name}-${random_id.random_id.hex}"
  region                 = var.region
  kms_encryption_enabled = false
}

resource "ibm_iam_authorization_policy" "flow_logs_authorization" {
  # depends_on           = [module.cos]
  count = var.create_policy == true ? 1 : 0
  source_service_name  = "is"
  source_resource_type = "flow-log-collector"
  target_service_name  = "cloud-object-storage"
  roles                = ["Writer"]
}

resource "ibm_is_flow_log" "flow_logs" {
  depends_on     = [module.cos, ibm_iam_authorization_policy.flow_logs_authorization]
  name           = var.flow_logs_name
  target         = var.target
  active         = var.flow_logs_active
  storage_bucket = module.cos.bucket_name
  resource_group = var.resource_group_id
}

locals {
  flow_logs_name   = ibm_is_flow_log.flow_logs.name
  flow_logs_crn    = ibm_is_flow_log.flow_logs.crn
  flow_logs_id     = ibm_is_flow_log.flow_logs.id
  flow_logs_href   = ibm_is_flow_log.flow_logs.href
  flow_logs_vpc    = ibm_is_flow_log.flow_logs.vpc
  flow_logs_bucket = ibm_is_flow_log.flow_logs.storage_bucket
  flow_logs_active = ibm_is_flow_log.flow_logs.active
}