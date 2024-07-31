provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "amlandas-vpc" {
    cidr_block = var.cidr_range
    tags = {
      "Name"=var.vpc_name
    }
  
}

