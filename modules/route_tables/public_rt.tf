resource "aws_route_table" "pub_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id
  }

  tags = merge(
    tomap({
      "Name" = "${var.public_subnet_name}-rt"}
    ),var.tags
  )
}

resource "aws_route_table_association" "public_rt_association" {
  count          = length(var.zones)
  subnet_id      = element(var.pub_subnets, count.index)
  route_table_id = aws_route_table.pub_rt.id
}

