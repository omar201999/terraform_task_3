resource "aws_lb" "public_lb" {
  name               = "public-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.public_security_group_id]
  subnets            = var.public_subnets

  tags = {
    Name        = "public-lb"
    Environment = "dev"
  }
}

resource "aws_lb" "private_lb" {
  name               = "private-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.private_security_group_id]
  subnets            = var.private_subnets

  tags = {
    Name        = "private-lb"
    Environment = "dev"
  }
}

resource "aws_lb_target_group" "public_target_group" {
  name     = "public-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  tags = {
    Name = "public-target-group"
    Environment = "dev"
  }
}

resource "aws_lb_target_group" "private_target_group" {
  name     = "private-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  tags = {
    Name = "private-target-group"
    Environment = "dev"
  }
}

resource "aws_lb_target_group_attachment" "public_target_group_1" {
  target_group_arn = aws_lb_target_group.public_target_group.arn
  target_id        = var.public_ec2_1
  port             = 80
}

resource "aws_lb_target_group_attachment" "public_target_group_2" {
  target_group_arn = aws_lb_target_group.public_target_group.arn
  target_id        = var.public_ec2_2
  port             = 80
}

resource "aws_lb_target_group_attachment" "private_target_group_1" {
  target_group_arn = aws_lb_target_group.private_target_group.arn
  target_id        = var.private_ec2_1
  port             = 80
}

resource "aws_lb_target_group_attachment" "private_target_group_2" {
  target_group_arn = aws_lb_target_group.private_target_group.arn
  target_id        = var.private_ec2_2
  port             = 80
}

resource "aws_lb_listener" "public_lb" {
  
  load_balancer_arn = aws_lb.public_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.public_target_group.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "private_lb" {
 
  load_balancer_arn = aws_lb.private_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.private_target_group.arn
    type             = "forward"
  }
}