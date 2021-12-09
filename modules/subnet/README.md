```
module "aws_subnet" {
  source = "./modules/subnet"
  
  public_subnet_name              = var.public_subnet_name
  priv_name             = var.priv_name
  cidr                  = var.cidr
  vpc_id                = var.vpc.vpc_id
  zones                 = var.zones

  subnet_bits_private   = var.subnet_partitioning_bits_private
  subnet_bits_default   = var.subnet_partitioning_bits_default

  priv_name             = var.priv_name
  priv_subnet_start     = var.priv_subnet_start

  public_subnet_name              = var.public_subnet_name
  pub_subnet_start      = var.pub_subnet_start

  tags                  = var.tags       
}
```