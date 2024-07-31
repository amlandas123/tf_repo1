provider "aws" {
    access_key = var.access_key
    secret_key = var.secret_key
    region = "us-east-1"
}


variable "access_key" {
    type = string 
}

variable "secret_key" {
    type = string  
}

resource "aws_vpc" "amlandas-vpc" {
    cidr_block = "192.169.0.0/24"
    tags = {
      "Name"= "dasabihan123"
    }
  
}

