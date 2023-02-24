provider "aws" {
  region = "us-east-1"
  profile = "default"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

resource "aws_instance" "instance" {
     ami = "ami-0dfcb1ef8550277af"
     instance_type = "t2.micro"
     vpc_security_group_ids = ["sg-03a2a3546f7490dae"]
     key_name = "demo"
     user_data = file("jen.sh")
     tags = {
       Name = "eks server"
     }
}
resource "null_resource" "name" {
     
     connection {
         type = "ssh"
         user = "ec2-user"
         private_key = "${file("C:/Users/user/Downloads/demo.pem")}"
         host = aws_instance.instance.public_ip
     }

     provisioner "file" {
          source = "jen.sh"
          destination = "/tmp/jen.sh"
     }     
     
     
     provisioner "remote-exec" {
         inline = [
          "sudo chmod +x /tmp/jen.sh",
          "sudo /tmp/jen.sh",
             
          ]
     }
     depends_on = [aws_instance.instance]
}









     






 









    








