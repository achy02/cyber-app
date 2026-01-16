terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region = "us-east-1"  # You can change this to your preferred region
}

# 1. Networking & Security Configuration
resource "aws_security_group" "web_sg" {
  name        = "web_server_sg"
  description = "Security group for web server"

  # REMEDIATION APPLIED: Restricted SSH to specific administrative IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.168.1.100/32"] # FIXED: Restricted to Admin VPN/IP only
  }

  # Allow HTTP traffic for the web app
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

# 2. Virtual Machine / Compute Instance
resource "aws_instance" "web_server" {
  ami           = "ami-053b0d53c279acc90" # Ubuntu 22.04 LTS (HVM) in us-east-1
  instance_type = "t2.micro"              # Eligible for Free Tier

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  key_name = "my-key-pair" # Placeholder: You will need a key pair in AWS to login

  tags = {
    Name = "DevOps-Assignment-Instance"
  }
}
