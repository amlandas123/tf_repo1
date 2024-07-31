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




