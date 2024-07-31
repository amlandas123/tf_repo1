provider "aws" {

    region = "us-east-1"

}


terraform {

 backend "s3" {

    region = "us-east-1"
    bucket = "tfstate-nts16-2024"
    dynamodb_table = "nts16-dynamodbtable"   
    key = "desa_demo_key"

   }

}


variable "keyname" {

 type = string

}



resource "tls_private_key" "rsa" {

algorithm = "RSA"

rsa_bits = 4096

}



resource "aws_key_pair" "tf-key-pair" {

key_name = var.keyname

public_key = tls_private_key.rsa.public_key_openssh

}



resource "local_file" "tf-key" {

content = tls_private_key.rsa.private_key_pem

filename = var.keyname

}


resource "aws_instance" "web-server" {

 ami      = "ami-0a0e5d9c7acc336f1"

 instance_type = "t2.micro"

 key_name   = var.keyname





 

 provisioner "remote-exec" {

   inline = [

      "sudo apt-get update",
      "sudo apt-get update",
      "sudo apt install -y apache2",
      "sudo chmod -R 777 /var/www/html/"

	]

  }

	

 provisioner "file" {

  source   = "index.html"

  destination = "/var/www/html/index.html"

 }

 connection {

  user    = "ubuntu"

  private_key = "${file(local_file.tf-key.filename)}"

   host = "${aws_instance.web-server.public_ip}"

 }

}



