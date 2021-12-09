output "natgw_id" {
  value = aws_nat_gateway.nat.id
}

output "natgw_ip" {
  value = aws_nat_gateway.nat.public_ip
}