# THis is a terraform provider file, 
# where we define the provider details like AWS, Azure, GCP etc.
terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
  alias  = "aws"
  region = var.region # Here we are defining the region name, so that it will create the instance in the given region

}