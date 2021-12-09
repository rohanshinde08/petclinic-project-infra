# VPC
output "vpc_id" {
  value = module.aws_vpc.vpc_id
}

# Subnets
output "pub_subnets" {
  value = module.aws_subnet.pub_subnets
}

output "public_subnets_id" {
  value = module.aws_subnet.public_subnets_id
}

output "private_subnets_id" {
  value = module.aws_subnet.private_subnets_id
}

output "public_subnets_cidr" {
  value = module.aws_subnet.public_subnets_cidr
}

output "private_subnets_cidr" {
  value = module.aws_subnet.private_subnets_cidr
}

# Internet gateway
output "igw_id" {
  value = module.aws_internet_gateway.igw_id
}

# NAT Gateway
output "natgw_id" {
  value = module.aws_nat_gateway.natgw_id
}

output "natgw_ip" {
  value = module.aws_nat_gateway.natgw_ip
}

# Route Tables
output "priv_rt_id" {
  value = module.aws_route_table.priv_rt_id
}

output "pub_route_table_id" {
  value = module.aws_route_table.pub_rt_id
}

# Security groups
output "sg_id" {
  value = module.aws_security_group.sg_id
}
