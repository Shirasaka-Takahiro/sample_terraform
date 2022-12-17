##ALB
resource "aws_lb" "example" {
  name               = "example"
  internal           = false
  load_balancer_type = "application"
  security_groups    = "${aws_security_group.examplealb.id}"
  subnets            = "${[aws_subnet.examplepublic1a.id, aws_subnet.examplepublic1c.id]}"
  ip_address_type    = "ipv4"

  tags = {
    Name = "example"
  }
}

##Target Group
resource "aws_lb_target_group" "example" {
  name             = "example"
  target_type      = "instance"
  protocol_version = "HTTP1"
  port             = "80"
  protocol         = "HTTP"
  vpc_id           = "${aws_vpc.example.id}"

  health_check {
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 5
    matcher             = "200,301"
  }

  tags = {
    Name = "example"
  }
}

##Attach target group to the alb
resource "aws_lb_target_group_attachment" "example-taget-ec2" {
  target_group_arn = "${aws_lb_target_group.example.arn}"
  target_id        = "${aws_instance.example.id}"
}

##Listener
resource "aws_lb_listener" "example" {
  load_balancer_arn = "${aws_lb.example.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.example.arn}"
  }
}