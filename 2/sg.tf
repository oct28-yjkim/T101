resource "aws_security_group" "yjkim1_sg" {
  vpc_id      = aws_vpc.yjkim1_vpc.id
  name        = "T101 SG"
  description = "T101 Study SG"
}

resource "aws_security_group_rule" "yjkim1_sginbound" {
  type              = "ingress"
  from_port         = 0
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.yjkim1_sg.id
}

resource "aws_security_group_rule" "yjkim1_sgoutbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.yjkim1_sg.id
}
