provider "aws" {
  region = "eu-north-1"
}

resource "aws_security_group" "web_sg" {
  name = "web-security-group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server" {
  ami                    = "ami-0c1ac8a41498c1a9c"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = file("user_data.sh")
  
  tags = {
    Name = "Terraform-WebServer"
  }
}

output "public_ip" {
  value = aws_instance.web_server.public_ip
}