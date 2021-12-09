variable "vpc_id" {
    description = "VPI ID"
    type        = string
}

variable "priv_name" {
    description = "Name for private subnet"
    type        = string
}

variable "priv_subnets" {
    description = "List of private subnets"
    type        = list
    default     = []
}

variable "public_subnet_name" {
    description = "Name for public subnet"
    type        = string
}

variable "pub_subnets" {
    description = "List of public subnets"
    type        = list
    default     = []
}

variable "zones" {
    description = "List of availability zones"
    type        = list
    default     = []
}

variable "gateway_id"{
    description = "Internet gateway id"
    type        = string
}

variable "nat_gateway_id"{
    description = "NAT gateway id"
    type        = string
}

variable "tags" {
    description = "Resource Tags"
    type        = map(string)
    default     = {}
}