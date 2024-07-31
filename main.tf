provider "aws" {
   
    region = "us-east-1"
}


resource "aws_vpc" "amlandas-vpc" {
    cidr_block = "192.169.0.0/24"
    tags = {
      "Name"= "dasabihan2024"
    }
  
}

