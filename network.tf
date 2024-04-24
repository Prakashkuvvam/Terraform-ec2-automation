resource "aws_vpc" "myvpc" {
  cidr_block           = "17.17.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Name" = "Google VPC"
  }
}
resource "aws_subnet" "mysub" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "17.17.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "Google Subnet-1"
  }
}
resource "aws_internet_gateway" "myIGW" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    "Name" = "Google IGW"
  }
}
resource "aws_route_table" "myRT" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myIGW.id
  }
  tags = {
    "Name" = "Google RT"
  }
}
resource "aws_route_table_association" "myrt_assoc" {
  subnet_id      = aws_subnet.mysub.id
  route_table_id = aws_route_table.myRT.id
}
resource "aws_security_group" "mySG" {
  vpc_id = aws_vpc.myvpc.id
  dynamic "ingress" {
    for_each = var.cidrs
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}