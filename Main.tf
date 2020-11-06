terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

variable "region" {
  type        = string
  description = "AWS region to use. https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html"
  default = "us-east-1"
}

variable "resource_prefix" {
  type        = string
  description = "What prefix to use for creating unique resources"
}

variable "Website_Domain_Name" {
  type        = string
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
  # shared_credentials_file = "/Users/tf_user/.aws/credentials"
}