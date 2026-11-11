terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "my-s3-bucket-bucket-11--aps1-az1"
    key    = "sun/terraform.tfstate"
    region = "ap-south-1"
  }
}
provider "aws" {
  region = "ap-south-1"
}
