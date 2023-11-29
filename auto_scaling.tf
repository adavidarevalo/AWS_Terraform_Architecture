resource "aws_autoscaling_group" "asg_public_servers" {
  desired_capacity     = 1
  max_size             = 3
  min_size             = 1
  health_check_type    = "ELB"
  vpc_zone_identifier  = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]
  launch_configuration = aws_launch_configuration.launch_configuration.id
  metrics_granularity  = "1Minute"
  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "Autoscaling Group Public"
    propagate_at_launch = true
  }

  tag {
    key                 = "Enviroment"
    value               = "dev"
    propagate_at_launch = true
  }
}


resource "aws_autoscaling_attachment" "application_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg_public_servers.name
  lb_target_group_arn    = aws_lb_target_group.alb_target_group.arn
}