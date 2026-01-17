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
# 0. Key Pair Configuration
# Using existing key pair "my-key-pair" as requested



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
  instance_type = "t3.micro"              # Eligible for Free Tier (and supports encryption)

  user_data = <<-EOF
              #!/bin/bash
              # Update and install dependencies
              sudo apt-get update -y
              sudo apt-get install -y docker.io docker-compose git
              
              # Start Docker
              sudo systemctl start docker
              sudo systemctl enable docker
              
              # Clone repository
              git clone https://github.com/achy02/cyber-app.git /home/ubuntu/cyber-app
              
              # Run Application
              cd /home/ubuntu/cyber-app
              sudo docker-compose up -d --build
              EOF

  root_block_device {
    encrypted = true
  }

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  key_name = "my-key-pair"

  tags = {
    Name = "DevOps-Assignment-Instance"
  }
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.web_server.public_ip
}
