# resource "aws_nat_gateway" "nat_gateway" {
#   allocation_id = aws_instance.nat_instance.network_interface_ids[0]
#   subnet_id     = aws_subnet.public_subnet.id

#   tags = {
#     Name = "NatGateway"
#   }
# }
