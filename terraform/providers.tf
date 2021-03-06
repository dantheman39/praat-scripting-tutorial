terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region                  = var.region
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}