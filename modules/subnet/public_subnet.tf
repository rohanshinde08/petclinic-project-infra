resource "aws_subnet" "pub_subnets" {
  vpc_id            = var.vpc_id
  count             = length(var.zones)
  cidr_block        = cidrsubnet(var.cidr, var.subnet_bits_default, count.index + (var.public_subnet_start * length(var.zones)))
  availability_zone = var.zones[count.index]

  tags = merge(
    tomap({
      "Name" = "${var.public_subnet_name}-subnet-${count.index}"}
    ),var.tags
  )  

  lifecycle {
    create_before_destroy = true
  }
}