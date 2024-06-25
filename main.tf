terraform {
  
        backend "remote" {
        # The name of your Terraform Cloud organization.
        organization = "POC-dcarrillo"

        # The name of the Terraform Cloud workspace to store Terraform state files in.
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