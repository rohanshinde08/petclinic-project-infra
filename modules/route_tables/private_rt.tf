resource "aws_route_table" "priv_rt" {
  vpc_id = var.vpc_id

  tags = merge(
    tomap({
      "Name" = "${var.priv_name}-rt"}
    ),var.tags
  )
}

resource "aws_route" "priv_rt_route_entry_natgw" {
  route_table_id            = aws_route_table.priv_rt.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id             = var.nat_gateway_id
}

resource "aws_route_table_association" "priv_rt_association" {
  count          = length(var.zones)
  subnet_id      = element(var.priv_subnets, count.index)
  route_table_id = aws_route_table.priv_rt.id
}
