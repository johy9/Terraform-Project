#
resource "aws_vpc" "foodapp-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"

  tags = {
    Name = "foodapp-vpc"
  }
}

#public subnet
resource "aws_subnet" "food-pub-sn" {
  vpc_id     = aws_vpc.foodapp-vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "food public sn"
  }
}

#private subnet
resource "aws_subnet" "food-pvt-sn" {
  vpc_id     = aws_vpc.foodapp-vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "food prviate sn"
  }
}

#Internet gateway
resource "aws_internet_gateway" "food-igw" {
  vpc_id = aws_vpc.foodapp-vpc.id

  tags = {
    Name = "food igw"
  }
}

# PUBLIC ROUTE TABLE
resource "aws_route_table" "food-pub-RT" {
  vpc_id = aws_vpc.foodapp-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.food-igw.id
  }

  tags = {
    Name = "food public RT"
  }
}


# PRIVATE ROUTE TABLE
resource "aws_route_table" "food-pvt-RT" {
  vpc_id = aws_vpc.foodapp-vpc.id


  tags = {
    Name = "food private RT"
  }
}

# SUBNET ROUTE TABLE ASSOCIATION - PUBLIC 
resource "aws_route_table_association" "food-pub-asc" {
  subnet_id      = aws_subnet.food-pub-sn.id
  route_table_id = aws_route_table.food-pub-RT.id
}

# SUBNET ROUTE TABLE ASSOCIATION - PRIVATE RT
resource "aws_route_table_association" "food-pvt-asc" {
  subnet_id      = aws_subnet.food-pvt-sn.id
  route_table_id = aws_route_table.food-pvt-RT.id
}
