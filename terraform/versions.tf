terraform {
  required_version = "> 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.55"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.2.0"
    }
  }
}