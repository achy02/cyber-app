terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# 0. Key Pair Configuration
resource "aws_key_pair" "user_key" {
  key_name   = "my-key-pair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2p3A4sfG3mhj5l8ozdscG7TB6Bk5b/kZ8EnnrVF3ULa0XsOFUGFTzYgLmPEM8uY8avkJ3Id8kgZoO60WsVG7XKPmZW7DJM+5vVeyDhBnrhhPRmoZquAyW2j1aKKfh5iUHgWm2awt3U9XCcDSjqCUga/QcvVNzN2U5DHsO/L6KqXZJRPLXkPpZajnFONC8QeN3dTSXxMz4DFvIDDeb9TC9bIMV95nzE5F8y3BPnou+jfzy4N2z1W3WEAeVBdNXQrV/x/WuiSC8QrUvurafJ3cLC//YnYGqcq+/pjNnqOj8oiHSxXthdIjIu29Y9yZELzua/gYQ3oSao5f0WnEnMr6/"
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
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP outbound"
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS outbound"
  }
}

# 2. Virtual Machine / Compute Instance
resource "aws_instance" "web_server" {
  ami           = "ami-053b0d53c279acc90" # Ubuntu 22.04 LTS (HVM) in us-east-1
  instance_type = "t2.micro"              # Eligible for Free Tier

  root_block_device {
    encrypted = true
  }

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  key_name = aws_key_pair.user_key.key_name

  tags = {
    Name = "DevOps-Assignment-Instance"
  }
}
