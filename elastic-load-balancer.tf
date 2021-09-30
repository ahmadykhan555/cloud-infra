resource "aws_elb" "music-player-load-balancer" {
  name = "music-player-load-balancer"
  security_groups = [
    aws_security_group.load-balancer_http.id
  ]
  
  subnets = [
    aws_subnet.subnet-1.id,
    aws_subnet.subnet-2.id,
  ]

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:80/"
  }

  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "80"
    instance_protocol = "http"
  }

  cross_zone_load_balancing = true
}

#Creating Security Group
resource "aws_security_group" "load-balancer_http" {
  name        = "load-balancer_http"
  description = "Accept HTTP (TCP/IP) traffic"
  vpc_id = aws_vpc.prod-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Accept HTTP (TCP/IP) traffic"
  }
}



