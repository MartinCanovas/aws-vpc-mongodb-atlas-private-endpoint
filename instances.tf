module "bastion" {
  source                        = "git::https://github.com/clouddrove/terraform-aws-ec2.git?ref=tags/0.12.6"
  key_name                      = var.ssh_key_pair
  instance_type                 = var.ec2_bastion
  instance_count                = 1
  tenancy                       = "default"
  ami                           = var.ami
  disk_size                     = 10
  ebs_optimized                 = false
  ebs_volume_type               = "gp2"
  assign_eip_address            = false
  associate_public_ip_address   = true
  vpc_security_group_ids_list   = [aws_security_group.sg_bastion.id]
  subnet_ids                    = [lookup(module.public_subnets.az_subnet_ids, var.az1)]
  application                   = "bastion"
  managedby                     = "terraform"
  name                          = "bastion"
  environment                   = var.stage
  label_order                   = ["environment", "name"]
  instance_tags                 = var.instance_tags
}

module "app" {
  source                        = "git::https://github.com/clouddrove/terraform-aws-ec2.git?ref=tags/0.12.6"
  key_name                      = var.ssh_key_pair
  instance_type                 = var.ec2_app
  instance_count                = 1
  tenancy                       = "default"
  ami                           = var.ami
  user_data                     = "install_mongo.sh"
  disk_size                     = 10
  ebs_optimized                 = true
  ebs_volume_type               = "gp2"
  assign_eip_address            = false
  associate_public_ip_address   = false
  vpc_security_group_ids_list   = [aws_security_group.sg_app.id]
  subnet_ids                    = [lookup(module.private_subnets.az_subnet_ids, var.az1)]
  application                   = "MongoDB"
  managedby                     = "terraform"
  name                          = "mongodb-client"
  environment                   = var.stage
  label_order                   = ["environment", "name"]
  instance_tags                 = var.instance_tags
}