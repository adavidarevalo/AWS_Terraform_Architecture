resource "aws_instance" "server1" {
    ami = var.ami_instance
    instance_type = var.instance_type
    count = 2
    subnet_id = element([aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id], count.index)
    associate_public_ip_address = true
    key_name = aws_key_pair.key-class1.id    
    tags = {
      Name = "private-server",
      Owner = "terraform",
      Env = "dev"
    }
    vpc_security_group_ids = [aws_security_group.sg_public_access.id]
    user_data = file("userData.sh")
}