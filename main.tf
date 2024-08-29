resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
}

resource "aws_subnet" "pub_sub" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.pub_sub_cidr_block

  tags = {
    Name = "pub_sub"
  }
  depends_on = [aws_vpc.vpc]
}

resource "aws_subnet" "pvt_sub_1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.pvt_sub_1_cidr_block

  tags = {
    Name = "pvt_sub_1"
  }
  depends_on = [aws_vpc.vpc]
}

resource "aws_subnet" "pvt_sub_2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.pvt_sub_2_cidr_block

  tags = {
    Name = "pvt_sub_2"
  }
  depends_on = [aws_vpc.vpc]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw"
  }
}

resource "aws_route_table" "pub_sub_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "pub_sub_rt"
  }
  depends_on = [aws_vpc.vpc, aws_subnet.pub_sub, aws_internet_gateway.igw]

}

resource "aws_route_table" "pvt_sub_1_rt" {
  vpc_id = aws_vpc.vpc.id

#   route {
#     cidr_block     = var.pvt_sub_1_cidr_block
#     nat_gateway_id = aws_nat_gateway.nat_gw.id
#   }

  tags = {
    Name = "pvt_sub_1_rt"
  }
  depends_on = [aws_vpc.vpc, aws_subnet.pvt_sub_1]

}

resource "aws_route_table" "pvt_sub_2_rt" {
  vpc_id = aws_vpc.vpc.id

#   route {
#     cidr_block     = var.pvt_sub_2_cidr_block
#     nat_gateway_id = aws_nat_gateway.nat_gw.id
#   }

  tags = {
    Name = "pvt_sub_2_rt"
  }
  depends_on = [aws_vpc.vpc, aws_subnet.pvt_sub_2]

}

resource "aws_route" "pvt_route_1" {
  route_table_id            = aws_route_table.pvt_sub_1_rt.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gw.id

  depends_on = [ aws_route_table.pvt_sub_1_rt ]
}

resource "aws_route" "pvt_route_2" {
  route_table_id            = aws_route_table.pvt_sub_2_rt.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gw.id

  depends_on = [ aws_route_table.pvt_sub_2_rt ]
}

resource "aws_route_table_association" "pub_rt_as" {
  subnet_id      = aws_subnet.pub_sub.id
  route_table_id = aws_route_table.pub_sub_rt.id
}

resource "aws_route_table_association" "pvt_rt_1_as" {
  subnet_id      = aws_subnet.pvt_sub_1.id
  route_table_id = aws_route_table.pvt_sub_1_rt.id
}

resource "aws_route_table_association" "pvt_rt_2_as" {
  subnet_id      = aws_subnet.pvt_sub_2.id
  route_table_id = aws_route_table.pvt_sub_2_rt.id
}

resource "aws_eip" "lb" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.lb.id
  subnet_id = aws_subnet.pub_sub.id

  tags = {
    Name = "nat_gw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
#   depends_on = [aws_eip.lb] 
}


resource "aws_instance" "ec2_pub_sub" {
  ami           = var.ami_id
  instance_type = var.inst_type
  subnet_id     = aws_subnet.pub_sub.id

  tags = {
    Name = var.ec2_pub_sub
  }
  depends_on = [aws_subnet.pub_sub]
}

resource "aws_instance" "ec2_pvt_sub_1" {
  ami           = var.ami_id
  instance_type = var.inst_type
  subnet_id     = aws_subnet.pvt_sub_1.id

  tags = {
    Name = var.ec2_pvt_sub_1
  }
  depends_on = [aws_subnet.pvt_sub_1]
}

resource "aws_instance" "ec2_pvt_sub_2" {
  ami           = var.ami_id
  instance_type = var.inst_type
  subnet_id     = aws_subnet.pvt_sub_2.id

  tags = {
    Name = var.ec2_pvt_sub_2
  }
  depends_on = [aws_subnet.pvt_sub_2]
}