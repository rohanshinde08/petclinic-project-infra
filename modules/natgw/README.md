```
module "aws_nat_gateway" {
  source = "./modules/natgw"
  
  public_subnet_id      = var.public_subnet_id
  name                  = var.name
  tags                  = var.tags       
}
```