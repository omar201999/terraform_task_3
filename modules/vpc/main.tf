resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block #10.0.0.0/16
   tags = {
    Name = "my_vpc"
     Environment = "dev"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name        = "igw"
    Environment = "dev"
  }
}


