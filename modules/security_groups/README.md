```
module "aws_security_group" {
  source    = "./modules/security_groups"
  name      = var.name
  vpc_id    = var.vpc.vpc_id
  tags      = var.tags       
}
```