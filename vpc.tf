# Virtual Private Cloud
resource "aws_vpc" "prod-vpc" {
  cidr_block = "10.0.0.0/16"
  tags={
      Name="Production"
  }
}