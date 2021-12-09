resource "aws_eip" "nat" {
  vpc = true
  tags = merge(
    tomap({
      "Name" = "${var.name}-nat-eip"}
    ),var.tags,
    )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_id
  tags = merge(
    tomap({
      "Name" = "${var.name}-natgw"}
    ),var.tags,
  )

  lifecycle {
    create_before_destroy = true
  }
}