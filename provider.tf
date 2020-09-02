# Set Terraform Version
terraform {
  required_version = ">= 0.12.0"
}

# Configure the AWS Provider
provider "aws" {
  region  = var.region
  profile = "default"
}

# Configure the MongoDB Atlas Provider
provider "mongodbatlas" {
  version = "~> 0.4"
}