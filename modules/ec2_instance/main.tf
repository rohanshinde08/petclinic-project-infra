resource "aws_instance" "this" {
  ami                    = var.ami
  instance_type          = var.instance_type
  user_data              = file(var.user_data)
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  monitoring             = var.monitoring
  security_groups         = var.security_groups
  associate_public_ip_address = var.associate_public_ip_address
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  tenancy                              = var.tenancy
  tags = merge(
    tomap({
      "Name" = "${var.name}-ec2"}
    ),var.tags
  )

}