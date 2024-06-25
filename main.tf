terraform {
  
    cloud {
      organization = "POC-dcarrillo"

      workspaces {
        name = "poc"
      }
    }
    required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }

}


provider "aws" {
   region = "us-east-1"
}