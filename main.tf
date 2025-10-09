provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = "br-sao" #var.region
}

module "resource-group" {
  source                       = "terraform-ibm-modules/resource-group/ibm"
  version                      = "1.3.0"
  existing_resource_group_name = var.resource_group
}

## módulo de cos para flow logs

# resource "random_id" "random_id" {
#   byte_length = 6
# }

# module "cos" {
#   source  = "terraform-ibm-modules/cos/ibm"
#   version = "10.4.0"
#   resource_group_id = module.resource-group.resource_group_id
#   cos_instance_name = var.cos_instance_name
#   bucket_name = "${var.cos_bucket_name}-${random_id.random_id.hex}"
#   region = var.region
#   kms_encryption_enabled = false
# }

module "vpc" {
  source                      = "./modules/vpc"
  vpc_name                    = var.vpc_name
  resource_group_id           = module.resource-group.resource_group_id
  vpc_tags                    = var.tags
  default_address_prefix      = "manual"
  address_prefixes            = var.address_prefixes
  create_gateway              = false
  subnet_name_prefix          = "${var.vpc_name}-subnet"
  default_network_acl_name    = "${var.vpc_name}-acl"
  default_routing_table_name  = "${var.vpc_name}-rt"
  default_security_group_name = "${var.vpc_name}-sg"
  subnet                      = var.subnet
}


# módulo de ssh para criação da VSI