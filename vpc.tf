locals {
  public_cidr_block  = cidrsubnet(var.cidr_block, 1, 0)
  private_cidr_block = cidrsubnet(var.cidr_block, 1, 1)
}

module "vpc" {
  source     = "git::https://github.com/cloudposse/terraform-aws-vpc.git?ref=tags/0.10.0"
  namespace  = var.namespace
  stage      = var.stage
  name       = var.name_vpc
  cidr_block = var.cidr_block
  tags       = var.vpc_tags
}

resource "mongodbatlas_private_endpoint" "atlas" {
  project_id    = var.project_id
  provider_name = "AWS"
  region        = var.region
}

resource "aws_vpc_endpoint" "atlas" {
  vpc_id             = module.vpc.vpc_id
  service_name       = mongodbatlas_private_endpoint.atlas.endpoint_service_name
  vpc_endpoint_type  = "Interface"
  subnet_ids         = [lookup(module.private_subnets.az_subnet_ids, var.az1)]
  security_group_ids = [aws_security_group.sg_endpoint.id]
  tags               = var.vpc_tags
}

resource "mongodbatlas_private_endpoint_interface_link" "atlas" {
  project_id            = mongodbatlas_private_endpoint.atlas.project_id
  private_link_id       = mongodbatlas_private_endpoint.atlas.private_link_id
  interface_endpoint_id = aws_vpc_endpoint.atlas.id
}

module "public_subnets" {
  source              = "git::https://github.com/cloudposse/terraform-aws-multi-az-subnets.git?ref=tags/0.4.0"
  namespace           = var.namespace
  stage               = var.stage
  name                = var.name_subnet
  availability_zones  = [var.az1, var.az2]
  vpc_id              = module.vpc.vpc_id
  cidr_block          = local.public_cidr_block
  type                = "public"
  igw_id              = module.vpc.igw_id
  nat_gateway_enabled = "true"
  tags                = var.vpc_tags
}

module "private_subnets" {
  source             = "git::https://github.com/cloudposse/terraform-aws-multi-az-subnets.git?ref=tags/0.4.0"
  namespace          = var.namespace
  stage              = var.stage
  name               = var.name_subnet
  availability_zones = [var.az1, var.az2]
  vpc_id             = module.vpc.vpc_id
  cidr_block         = local.private_cidr_block
  type               = "private"
  az_ngw_ids         = module.public_subnets.az_ngw_ids
  tags               = var.vpc_tags
}