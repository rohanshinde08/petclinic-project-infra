```
module "aws_route_table" {
  source = "./modules/route_tables"
  
  public_subnet_name              = var.public_subnet_name
  priv_name             = var.priv_name
  vpc_id                = var.vpc_id
  zones                 = var.zones
  priv_subnets          = var.priv_subnets
  pub_subnets           = var.pub_subnets
  gateway_id            = var.gateway_id
  nat_gateway_id        = var.nat_gateway_id
  tags                  = var.tags       
}
```