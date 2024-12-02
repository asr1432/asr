resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Nmae = "vpc"

    }
}
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = true
    availability_zone = "ap-northeast-3a"

    tags = {
      Nmae = "pub_subnet"
    }
  
}
resource "aws_internet_gateway" "ig-1" {
    vpc_id = aws_vpc.main.id

    tags = {
      Nmae = "ig-1"
    }
  
}
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    tags = {
      Nmae = "pub-route"
    }
  
}
resource "aws_route" "internet-access" {
    route_table_id = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig-1.id

  
}
resource "aws_route_table_association" "public" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public.id

  
}

resource "aws_security_group" "sg" {
    vpc_id = aws_vpc.main.id
    tags = {
      Name = "sg"
    }

ingress{
    description="TLS from vpc"
    from_port=80
    to_port=80
    protocol="TCP"
    cidr_blocks=["0.0.0.0/0"]

}

ingress{
    description="tls from vpc"
    from_port=22
    to_port=22
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]

}
egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
}


  

resource "aws_subnet" "hyy" {
    availability_zone = "ap-northeast-3b"
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.main.id
  
}
resource "aws_eip" "hyy" {
  tags = {
    Name = "asr"
  }

}

resource "aws_nat_gateway" "nat" {
  connectivity_type = "public"
  subnet_id = aws_subnet.hyy.id
  allocation_id = aws_eip.hyy.id
  
}

resource "aws_route_table" "hyy" {
    vpc_id = aws_vpc.main.id
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat.id
    }
 }
 resource "aws_route_table_association" "hyy" {
route_table_id = aws_route_table.hyy.id 
subnet_id = aws_subnet.hyy.id  
}

resource "aws_instance" "public" {
    ami = "ami-0614680123427b75e"
    instance_type = "t2.micro"
    key_name = "awskey"
    security_groups = [aws_security_group.sg.id]
    associate_public_ip_address = true
    subnet_id = aws_subnet.hyy.id
    tags = {
      Name="pubec2"
    }

}

resource "aws_instance" "private" {
    ami = "ami-0614680123427b75e"
    instance_type = "t2.micro"
    key_name = "awskey"
    security_groups = [aws_security_group.sg.id]
    associate_public_ip_address = false
    subnet_id = aws_subnet.hyy.id
    tags = {
      Name="private"
    }

}
