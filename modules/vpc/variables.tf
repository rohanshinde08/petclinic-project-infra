variable "name" {
  description = "Name to be used on all the resources as identifier"
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
    type        = map(string)
    default     = {}
}
