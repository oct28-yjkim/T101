resource "aws_security_group" "mysg" {
  vpc_id      = aws_vpc.myvpc.id
  name        = "sg"
  description = "sg"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "amazonlinux2" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "test" {
  ami                    = data.aws_ami.amazonlinux2.id
  instance_type          = "t3.micro"
  key_name               = "220522"
  subnet_id              = aws_subnet.mysubnet1.id
  vpc_security_group_ids = [aws_security_group.mysg.id]
  iam_instance_profile   = aws_iam_instance_profile.test-ec2.name
  user_data_replace_on_change = true
  user_data = <<EOF
#!/bin/bash
aws secretsmanager create-secret --region ap-northeast-2 --name MySecret --secret-string '{\"password\":\"${local.password}\"}'
  EOF
}
output "connection" {
  value = aws_instance.test.public_ip
}