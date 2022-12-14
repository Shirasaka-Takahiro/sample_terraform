##Security Group for Web instance
resource "aws_security_group" "examplehttp" {
  vpc_id = aws_vpc.example.id
  tags = {
    Name = "examplehttp"
  }
}

resource "aws_security_group_rule" "in_ssh" {
  security_group_id = aws_security_group.examplehttp.id
  type              = "ingress"
  cidr_blocks       = ["119.229.192.95/32"]
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
}

resource "aws_security_group_rule" "internal" {
  security_group_id = aws_security_group.examplehttp.id
  type              = "ingress"
  cidr_blocks       = ["10.0.0.0/16"]
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
}

resource "aws_security_group_rule" "out_all" {
  security_group_id = aws_security_group.examplehttp.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
}

##Security Group for alb
resource "aws_security_group" "examplealb" {
  vpc_id = aws_vpc.example.id
  tags = {
    Name = "examplealb"
  }
}

resource "aws_security_group_rule" "in_http" {
  security_group_id = aws_security_group.examplealb.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
}

resource "aws_security_group_rule" "out_allalb" {
  security_group_id = aws_security_group.examplealb.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
}