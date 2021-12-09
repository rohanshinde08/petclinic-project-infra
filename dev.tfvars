team_name   = "pet-clinic"
owner       = "ron"
environment = "dev"
prefix      = "pet-clinic"

# VPC
cidr = "172.20.0.0/16"

# Subnets
region                            = "ap-south-1"
zones                             = ["ap-south-1a"]
subnet_partitioning_start_private = 10
subnet_partitioning_start_public  = 20
subnet_partitioning_bits_private  = 0
subnet_partitioning_bits_default  = 8

# IGW
# NATGW
# RT

# jenkins Instance
jenkins_ami                          = "ami-0108d6a82a783b352" //Amazon Linux 2 AMI (HVM), SSD Volume Type
jenkins_instance_type                = "t2.medium"
key_name                             = "pet-clinic"
monitoring                           = false
instance_initiated_shutdown_behavior = "stop"
tenancy                              = "default"

#docker 
docker_ami           = "ami-0108d6a82a783b352" //Amazon Linux 2 AMI (HVM), SSD Volume Type
docker_instance_type = "t2.medium"

