```
module "aws_instance" {
  source                               = ./modules/ec2_instance
  count                                = var.instance_count
  ami                                  = var.ami
  instance_type                        = var.instance_type
  user_data                            = file(var.user_data)
  subnet_id                            = var.subnet_id
  key_name                             = var.key_name
  monitoring                           = var.monitoring
  security_groups                       = security_groups
  associate_public_ip_address          = var.associate_public_ip_address
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  tenancy                              = var.tenancy
  tags                                 = var.tags
```