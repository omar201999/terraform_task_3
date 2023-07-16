resource "aws_subnet" "public1" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
    tags = {
    Name = "public1_subnet"
     Environment = "dev"
  }
}

resource "aws_subnet" "public2" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
     tags = {
    Name = "public2_subnet"
     Environment = "dev"
  }
}

resource "aws_subnet" "private1" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
     tags = {
    Name = "private1_subnet"
     Environment = "dev"
  }
}

resource "aws_subnet" "private2" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1b"
     tags = {
    Name = "private2_subnet"
     Environment = "dev"
  }
}


resource "aws_eip" "nat" {
  vpc        = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.public1.id
    tags = {
    Name = "my_nat_gateway"
    Environment = "dev"
  }

}

resource "aws_route_table" "route_table_public" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
  tags = {
    Name = "route_table_public"
    Environment = "dev"
  }
}

resource "aws_route_table" "route_table_private" {
  vpc_id = var.vpc_id
  route  {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "route_table_private"
    Environment = "dev"
  }
}


resource "aws_route_table_association" "route_table_public1_association" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.route_table_public.id
}

resource "aws_route_table_association" "route_table_public2_association" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.route_table_public.id
}

resource "aws_route_table_association" "route_table_private1_association" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.route_table_private.id
}

resource "aws_route_table_association" "route_table_private2_association" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.route_table_private.id
}