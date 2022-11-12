
#Instance Role
resource "aws_iam_role" "yjkim1_role" {
  name = "yjkim1-ssm"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Name = "yjkim1-ssm"
  }
}


resource "aws_iam_instance_profile" "yjkim1_profile" {
  name = "yjkim1-ssm"
  role = "${aws_iam_role.yjkim1_role.id}"
}

resource "aws_iam_policy_attachment" "yjkim1_attach1" {
  name       = "yjkim1-attachment"
  roles      = [aws_iam_role.yjkim1_role.id]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}
