#####################################################
# VPC Resource Configuration
# Copyright 2020 IBM
#####################################################

data "ibm_is_vpc" "vpc_ds" {
  count = var.create_vpc ? 0 : 1
  name  = var.vpc
}

resource "ibm_is_vpc" "vpc" {
  count                       = var.create_vpc ? 1 : 0
  name                        = var.vpc_name
  resource_group              = var.resource_group_id
  address_prefix_management   = var.default_address_prefix
  default_network_acl_name    = var.default_network_acl_name
  default_security_group_name = var.default_security_group_name
  default_routing_table_name  = var.default_routing_table_name
  tags                        = var.vpc_tags
  no_sg_acl_rules             = var.clean_default_sg_acl
}

#####################################################
# Create Prefixes
#####################################################

resource "ibm_is_subnet" "subnets" {
  #   count                    = length(var.locations)
  depends_on = [ ibm_is_vpc_address_prefix.vpc_address_prefixes ]
  for_each        = { for s in var.subnet : s.name => s }
  name            = each.value["name"]
  resource_group  = var.resource_group_id
  vpc             = var.create_vpc ? ibm_is_vpc.vpc[0].id : data.ibm_is_vpc.vpc_ds[0].id
  zone            = each.value["location"]
  ipv4_cidr_block = each.value["ipv4_cidr_block"]
  routing_table   = var.create_vpc ? ibm_is_vpc.vpc[0].default_routing_table : data.ibm_is_vpc.vpc_ds[0].id
}

resource "ibm_is_vpc_address_prefix" "vpc_address_prefixes" {
  for_each = { for r in var.address_prefixes : r.name => r }
  name     = each.value["name"]
  vpc      = var.create_vpc ? ibm_is_vpc.vpc[0].id : data.ibm_is_vpc.vpc_ds[0].id
  zone     = each.value["location"]
  cidr     = each.value["ip_range"]
}

#####################################################
# Create Subnets
#####################################################


