# Route Table
resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.prod-vpc.id

    route {
     cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.gateway.id
   }

   route {
     ipv6_cidr_block = "::/0"
     gateway_id      = aws_internet_gateway.gateway.id
   }

  tags = {
    Name = "Production"
  }
}