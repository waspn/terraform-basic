# define the provider version and backend for remote state
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.16.0"
    }
  }
  backend "s3" {
    bucket = var.bucket_name
    key    = var.bucket_key
    region = var.region
  }
}

# Configure the AWS Provider
provider "aws" {
  region                  = var.provider_region[0]
  shared_credentials_file = var.provider_credential
  profile                 = var.provider_region
}
# Optional for multiple region resource
provider "aws" {
  alias                   = "opt_region"
  region                  = var.provider_region[1]
  shared_credentials_file = var.provider_credential
  profile                 = var.provider_region
}

# Define resource as module
module "dynamodb" {
  # Define the region that resource will be created (optional)
  # providers = { aws = aws.opt_region }

  source = "./modules/dynamodb"
  # additonal input variable can be added more
}
