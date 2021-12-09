```
module "aws_vpc" {
  source = "./modules/vpc"
  
  name                  = var.name
  cidr                  = var.cidr
  instance_tenancy      = var.instance_tenancy
  enable_dns_hostnames  = var.enable_dns_hostnames
  enable_dns_support    = var.enable_dns_support
  tags                  = var.tags       
}
```