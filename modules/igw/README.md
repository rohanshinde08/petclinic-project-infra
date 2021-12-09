```
module "aws_internet_gateway" {
  source = "./modules/igw"
  
  public_subnet_name              = var.vpc_id
  name                  = var.name
  tags                  = var.tags       
}
```