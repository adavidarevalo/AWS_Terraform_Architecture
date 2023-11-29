resource "aws_launch_configuration" "launch_configuration" {
  name            = "my-lc_test"
  instance_type   = var.ec2_type
  security_groups = [aws_security_group.sg_public_access.id]
  image_id        = var.ec2_ami
  user_data       = file("userData.sh")
    associate_public_ip_address = true
  lifecycle {
    create_before_destroy = true
  }
}