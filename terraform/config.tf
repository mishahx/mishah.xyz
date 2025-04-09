provider "aws" {
  region  = var.aws_region
}

variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

terraform {
  required_version = "> 1.9.0"

  required_providers {
    aws = {
      source = "hashicorp/aws" # Specify the source of the AWS provider
      version = "~> 5.0"        # Use a version of the AWS provider that is compatible with version
    }
  }

  backend "s3" {
    region = "ap-south-1"
    bucket = "ms92-tf-states"
    dynamodb_table = "ms92-tf-states"
    encrypt = true
    key = "mishah/mishah_xyz/tfstate"
  }
}