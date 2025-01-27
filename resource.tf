# This is a resource file, 
# Were we will define an ec2 instance with an load balancer via terraform.
# step 1 : First stepis to create a vpc so that we can create the instance in the vpc.
resource "aws_vpc" "vpc_instance" {
  cidr_block = var.aws_cidr_block_vartf # Here we are defining the cidr block for the vpc and that too we will define in the variable file
  tags = {
    Name = var.aws_vpc_name # Here we are defining the name of the vpc from a variable, so that it will create the vpc with the given name
  }
}
output "aws_vpc_output" {
  value = aws_vpc.vpc_instance
}
# step 2 : Create a subnet in the vpc so that we can create the instance in the subnet
resource "aws_subnet" "public-subnet" {
  vpc_id            = aws_vpc.vpc_instance.id
  cidr_block        = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
    Name = "terraform-public-subnet"
    }
}
output "aws_subnet_output" {
  value = aws_subnet.public-subnet
}
# step 3 : Create an internet gateway so that we can connect the vpc to the internet
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc_instance.id # Here we are tagging the IGW to the VPC
    tags = {
    Name = "terraform-igw"
    }
}
output "aws_igw_output" {
    value = aws_internet_gateway.igw
    }
# step 4 : Create a route table so that we can route the traffic from the vpc to the internet
resource "aws_route_table" "route_table" {
    vpc_id = aws_vpc.vpc_instance.id
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id # Here we are connecting the route table to the IGW
    }
    tags = {
    Name = "terraform-route-table"
    }
}
output "aws_route_table_output" {
    value = aws_route_table.route_table
}
# step 5 : Create a route table association so that we can associate the route table to the subnet
resource "aws_route_table_association" "route_table_association_public_subnet" {
    subnet_id      = aws_subnet.public-subnet.id # Here we are connecting the route table to the public subnet
    route_table_id = aws_route_table.route_table.id
}
output "aws_route_table_association_output" {
    value = aws_route_table_association.route_table_association_public_subnet
}
# step 6 : Create a security group so that we can allow the traffic to the instance
