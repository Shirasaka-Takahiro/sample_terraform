##AMI
data "aws_ami" "iam-image" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "block-device-mapping.volume-type"
    values = ["gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

}

##EC2
resource "aws_instance" "example" {
  ami                    = data.aws_ami.ima-image.image_id
  vpc_security_group_ids = ws_security_group.examplehttp.id
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