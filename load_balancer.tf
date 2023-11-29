resource "aws_lb_target_group" "alb_target_group" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_vpc.id
  target_type = "instance"
}


resource "aws_lb" "main_lb" {
  load_balancer_type               = "application"
  security_groups                  = [aws_security_group.lb_security_group.id]
  subnets                          = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]
  enable_deletion_protection       = false
  enable_http2                     = true
  idle_timeout                     = 60
  enable_cross_zone_load_balancing = true
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.main_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.alb_target_group.arn
    type             = "forward"
  }
}
