##EC2
resource "aws_instance" "ec2-instance" {
  ami                    = "${var.ami}"
  vpc_security_group_ids = aws_security_group.examplehttp.id
  subnet_id              = aws_subnet.examplepublic1a.id
  key_name               = aws_key_pair.example.id
  instance_type          = "t2.micro"

  tags = {
    Name = "example"
  }

}

##Elastic IP
resource "aws_eip" "example" {
  instance = aws_instance.example.id
  vpc      = true
}

##Key Pair
resource "aws_key_pair" "example" {
  key_name   = "example"
  public_key = file("~/.ssh/example.pub")
}