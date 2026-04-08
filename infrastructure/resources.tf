# VPC
resource "aws_vpc" "movie-pulse-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "movie-pulse"
  }
}


# Subnet
resource "aws_subnet" "movie-pulse-subnet" {
  vpc_id            = aws_vpc.movie-pulse-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "movie-pulse-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "movie-pulse-igw" {
  vpc_id = aws_vpc.movie-pulse-vpc.id

  tags = {
    Name = "movie-pulse-igw"
  }
}


# Route Table
resource "aws_route_table" "movie-pulse-rt" {
  vpc_id = aws_vpc.movie-pulse-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.movie-pulse-igw.id
  }

  tags = {
    Name = "movie-pulse-rt"
  }
}

# Route Table Association
resource "aws_route_table_association" "movie-pulse-rt-association" {
  subnet_id      = aws_subnet.movie-pulse-subnet.id
  route_table_id = aws_route_table.movie-pulse-rt.id
}

# Security Groups
resource "aws_security_group" "movie-pulse-sg" {
  name        = "movie-pulse-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.movie-pulse-vpc.id

  tags = {
    Name = "movie-pulse-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.movie-pulse-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.movie-pulse-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}


resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.movie-pulse-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}