
terraform {
  required_version = ">= 0.13"

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket         = "spride-aws-infra-dev"
    key            = "terraform/us-east-1/vpc/vpc.state"
    region         = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

