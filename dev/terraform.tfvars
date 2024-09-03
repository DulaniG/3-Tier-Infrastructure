vpc_name = "my_vpc"
vpc_cidr_block = "10.0.0.0/24"
availability_zones = ["us-east-1a", "us-east-1b"]
private_subnets = ["10.0.0.32/27", "10.0.0.64/27"]
public_subnets = ["10.0.0.0/27"]
enable_nat_gateway = true
enable_vpn_gateway = false
create_multiple_intra_route_tables = true
create_multiple_public_route_tables = true
terraform_tag = true
environment_tag = "dev"



# cidr_block = "10.0.0.0/24"
# pub_sub_cidr_block = "10.0.0.0/27"
# pvt_sub_1_cidr_block = "10.0.0.32/27"
# pvt_sub_2_cidr_block = "10.0.0.64/27"
# ami_id = "ami-066784287e358dad1"
# inst_type = "t2.micro"
# ec2_pub_sub = "ec2_pub_sub"
# ec2_pvt_sub_1 = "ec2_pvt_sub_1"
# ec2_pvt_sub_2 = "ec2_pvt_sub_2"
# db_name = "pvt_sub_2_db"