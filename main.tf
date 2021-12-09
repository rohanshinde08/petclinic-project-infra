locals {
  tags = {
    team        = var.team_name
    owner       = var.owner
    environment = var.environment
  }
}
# VPC
module "aws_vpc" {
  source               = "./modules/vpc"
  name                 = var.prefix
  cidr                 = var.cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags                 = local.tags
}

# Subnets
module "aws_subnet" {
  source               = "./modules/subnet"
  cidr                 = var.cidr
  vpc_id               = module.aws_vpc.vpc_id
  zones                = var.zones
  subnet_bits_private  = var.subnet_partitioning_bits_private
  subnet_bits_default  = var.subnet_partitioning_bits_default
  private_subnet_name  = "${var.prefix}-private"
  private_subnet_start = var.subnet_partitioning_start_private
  public_subnet_name   = "${var.prefix}-public"
  public_subnet_start  = var.subnet_partitioning_start_public
  tags                 = local.tags
}

# IGW
module "aws_internet_gateway" {
  source = "./modules/igw"
  vpc_id = module.aws_vpc.vpc_id
  name   = var.prefix
  tags   = local.tags
}

# NATGW
module "aws_nat_gateway" {
  source           = "./modules/natgw"
  public_subnet_id = module.aws_subnet.public_subnets_id
  name             = var.prefix
  tags             = local.tags
}

# Route Tables
module "aws_route_table" {
  source             = "./modules/route_tables"
  vpc_id             = module.aws_vpc.vpc_id
  zones              = var.zones
  public_subnet_name = "${var.prefix}-public-subnet"
  priv_name          = "${var.prefix}-private-subnet"
  priv_subnets       = module.aws_subnet.priv_subnets
  pub_subnets        = module.aws_subnet.pub_subnets
  gateway_id         = module.aws_internet_gateway.igw_id
  nat_gateway_id     = module.aws_nat_gateway.natgw_id
  tags               = local.tags
}

# Security group
module "aws_security_group" {
  source = "./modules/security_groups"
  name   = "${var.prefix}-jenkins"
  vpc_id = module.aws_vpc.vpc_id
  tags   = local.tags
}

# Instance for jenkins
module "aws_instance_jenkins" {
  source                               = "./modules/ec2_instance"
  name                                 = "${var.prefix}-jenkins-master"
  ami                                  = var.jenkins_ami
  instance_type                        = var.jenkins_instance_type
  user_data                            = "./deploy/jenkins.sh"
  subnet_id                            = module.aws_subnet.public_subnets_id
  key_name                             = var.key_name
  monitoring                           = var.monitoring
  security_groups                      = [module.aws_security_group.sg_id]
  associate_public_ip_address          = true
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  tenancy                              = var.tenancy
  tags                                 = local.tags
}

# Insance for docker
module "aws_instance_docker" {
  source                               = "./modules/ec2_instance"
  name                                 = "${var.prefix}-docker"
  ami                                  = var.docker_ami
  instance_type                        = var.docker_instance_type
  user_data                            = "./deploy/docker.sh"
  subnet_id                            = module.aws_subnet.private_subnets_id
  key_name                             = var.key_name
  monitoring                           = var.monitoring
  security_groups                      = [module.aws_security_group.sg_id]
  associate_public_ip_address          = false
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  tenancy                              = var.tenancy
  tags                                 = local.tags
}