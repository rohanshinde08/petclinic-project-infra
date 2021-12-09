# TAGS
variable "team_name" {
  default = ""
}
variable "owner" {
  default = ""
}
variable "environment" {
  default = ""
}


# VPC
variable "prefix" {
  description = "Prefix to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "0.0.0.0/0"
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = false
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Resource Tags"
  type        = map(any)
  default     = {}
}

# Subnets
variable "zones" {
  description = "List of availability zones"
  type        = list(any)
  default     = []
}

variable "subnet_partitioning_bits_private" {
  default = "2"
}

variable "subnet_partitioning_bits_default" {
  default = "4"
}

variable "region" {
}

variable "subnet_partitioning_start_private" {
  default = "1"
}

variable "subnet_partitioning_start_public" {
  default = "2"
}

# EC2
variable "jenkins_ami" {}
variable "docker_ami" {}
variable "jenkins_instance_type" {}
variable "docker_instance_type" {}
variable "key_name" {}
variable "monitoring" {}
variable "instance_initiated_shutdown_behavior" {}
variable "tenancy" {}
