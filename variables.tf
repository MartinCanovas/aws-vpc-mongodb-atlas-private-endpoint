variable "project_id" {
  description = "Atlas Project ID"
  default     = ""
}

variable "cluster_name" {
  default = "myCluster"
}

variable "db_username" {
  default = "terraform"
}

variable "db_user_password" {
  default = "terraform"
}

variable "email_address" {
  default = ""
}

variable "whitelist_ip" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "whitelist_ip_desc" { 
  default = "Added by Terraform" 
}

variable "replication_factor" {
  description = "Number of members in the replica set"
  default     = "3"
}

variable "mongo_db_major_version" {
  description = "MongoDB version"
  default     = "4.4"
}

variable "provider_instance_size_name" {
  description = "Instance type"
  default     = "M10"
}

variable "provider_region_name" {
  description = "Provider region"
  default     = "US_EAST_1"
}

variable "region" {
  default = "us-east-1"
}

variable "az1" {
  default = "us-east-1a"
}

variable "az2" {
  default = "us-east-1b"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "stage" {
  default = "dev"
}

variable "name_vpc" {
  default = "vpc"
}

variable "name_subnet" {
  default = "subnet"
}

variable "ec2_bastion" {
  default = "t3a.nano"
}

variable "ec2_app" {
  default = "t3a.small"
}

variable "ami" {
  default = ""
}

variable "namespace" {
  default = ""
}

variable "name_ec2" {
  default = "ec2"
}

variable "ssh_key_pair" {
  default = ""
}

variable "access_logs_region" {
  default = "us-east-1"
}

variable "vpc_tags" {
  default = {
    Name      = ""
    expire-on = ""
    owner     = ""
    misc      = "Managed by Terraform"
  }
}

variable "instance_tags" {
  default = {
    expire-on = ""
    owner     = ""
  }
}