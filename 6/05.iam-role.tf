resource "aws_iam_role" "test-ec2" {
  name = "test-ec2"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_policy" "secret_manager" {
  name        = "testSecretManager"
  path        = "/"
  description = "testSecretManager"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "secretsmanager:*",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "test-ec2" {
  name = "test-ec2"
  role = aws_iam_role.test-ec2.name
}

resource "aws_iam_role_policy_attachment" "test" {
  role       = aws_iam_role.test-ec2.name
  policy_arn = aws_iam_policy.secret_manager.arn
}