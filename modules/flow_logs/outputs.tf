### COS Outputs

output "s3_endpoint_private" {
  description = "S3 private endpoint"
  value       = module.cos.s3_endpoint_private
}

output "s3_endpoint_public" {
  description = "S3 public endpoint"
  value       = module.cos.s3_endpoint_public
}

output "s3_endpoint_direct" {
  description = "S3 direct endpoint"
  value       = module.cos.s3_endpoint_direct
}

output "bucket_id" {
  description = "Bucket ID"
  value       = module.cos.bucket_id
}

output "bucket_crn" {
  description = "Bucket CRN"
  value       = module.cos.bucket_crn
}

output "bucket_name" {
  description = "Bucket name"
  value       = module.cos.bucket_name
  # Don't output the bucket name until it exists (see https://github.com/terraform-ibm-modules/terraform-ibm-cos/issues/558)
  depends_on = [module.cos.bucket_crn]
}

output "bucket_region" {
  description = "Bucket region if a regional bucket is created"
  value       = module.cos.bucket_region
}

output "cos_instance_id" {
  description = "The ID of the Object Storage instance"
  value       = module.cos.cos_instance_id
}

output "cos_instance_guid" {
  description = "The GUID of the Object Storage instance"
  value       = module.cos.cos_instance_guid
}

output "cos_instance_name" {
  description = "The name of the Object Storage instance"
  value       = module.cos.cos_instance_name
}

output "cos_instance_crn" {
  description = "The CRN of the Object Storage instance"
  value       = module.cos.cos_instance_crn
}

#### Flow Logs Outputs

output "flow_logs_name" {
  description = "The name of the Flow Logs instance"
  value       = local.flow_logs_name
}

output "flow_logs_crn" {
  description = "The CRN of the Flow Logs instance"
  value       = local.flow_logs_crn
}

output "flow_logs_id" {
  description = "The ID of the Flow Logs instance"
  value       = local.flow_logs_id
}

output "flow_logs_href" {
  description = "The URL of the Flow Logs collector"
  value       = local.flow_logs_href
}

output "flow_logs_vpc" {
  description = "The VPC the Flow Logs is associated to"
  value       = local.flow_logs_vpc
}

output "flow_logs_bucket" {
  description = "The name of the bucket the Flow Logs collector sends logs to"
  value       = local.flow_logs_bucket
}

output "flow_logs_active" {
  description = "If the Flow Log is active or not"
  value       = local.flow_logs_active
}