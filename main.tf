provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.region
}

data "ibm_resource_group" "rg" {
  name = var.resource_group
}

# # módulo para criar VPC

module "vpc" {
  source                      = "./modules/vpc"
  vpc_name                    = var.vpc_name
  resource_group_id           = data.ibm_resource_group.rg.id
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

# # módulo de flow logs

module "flow_logs" {
  source            = "./modules/flow_logs"
  depends_on        = [module.vpc]
  cos_bucket_name   = var.cos_bucket_name
  cos_instance_name = var.cos_instance_name
  flow_logs_name    = var.flow_logs_name
  flow_logs_active  = var.flow_logs_active
  target            = module.vpc.vpc_id
  resource_group_id = data.ibm_resource_group.rg.id
  create_policy     = var.create_policy
}

# # módulo de ssh para criação da VSI

module "ssh_key" {
  source            = "./modules/ssh_key"
  ssh_key           = var.ssh_keys
  prefix            = var.vpc_name
  resource_group_id = data.ibm_resource_group.rg.id
  create_ssh_key    = var.create_ssh_key
}

# # módulo da VSI

module "vsi" {
  depends_on        = [module.ssh_key, module.vpc]
  source            = "./modules/vsi"
  vni_name          = var.vni_name
  vni_subnet        = module.vpc.subnet_ids[0]
  vsi_name          = var.vsi_name
  vsi_profile       = var.vsi_profile
  vsi_vpc_id        = module.vpc.vpc_id
  resource_group_id = data.ibm_resource_group.rg.id
  ssh_keys          = [module.ssh_key.ssh_key_id]
  image_name        = var.vsi_image_name
  tags              = var.tags
}