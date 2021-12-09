resource "aws_internet_gateway" "igw" {
   vpc_id = var.vpc_id

   tags = merge(
     tomap({
       "Name" = "${var.name}-vpc-igw"}
       ),var.tags
      ) 
}