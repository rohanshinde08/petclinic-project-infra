output "pub_subnets" {
  value = aws_subnet.pub_subnets.*.id
}

output "priv_subnets" {
  value = aws_subnet.priv_subnets.*.id
}

output "public_subnets_id" {
  value = element(aws_subnet.pub_subnets.*.id, 0)
}

output "private_subnets_id" {
  value = element(aws_subnet.priv_subnets.*.id, 0)
}
output "public_subnets_cidr" {
  value = aws_subnet.pub_subnets.*.cidr_block
}

output "private_subnets_cidr" {
  value = aws_subnet.priv_subnets.*.cidr_block
}


