# Provider
provider "aws" {
  region  = "us-east-1"
  version = "~> 2.63.0"
  shared_credentials_file = "C:\\Users\\ahmad\\.aws\\credentials" 
}

# Internet Gateway
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.prod-vpc.id
}

# Network Interface
resource "aws_network_interface" "web-server-app" {
  subnet_id       = aws_subnet.subnet-1.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.ports.id]
}

# Security Group to Allow Ports 80, 3306
# Inbound rules
resource "aws_security_group" "ports" {
  name        = "allow_web_traffic"
  description = "Allow Web inbound traffic"
  vpc_id      = aws_vpc.prod-vpc.id


  ingress {
    description = "MYSQL/Aurora Access"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress{
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  # Outbound rules
  egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  
  tags = {
    Name = "ports"
  }
}
