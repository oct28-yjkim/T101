locals {
  name   = "simple"
  region = "ap-southeast-1"
  tags = {
    Owner       = "yjkim1"
    Environment = "dev"
  }
}

resource "aws_db_subnet_group" "database" {
  name       = "database"
  subnet_ids = [aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_c.id]

  tags = {
    Name = "simple DB subnet group"
  }
}


module "aurora" {
  source  = "terraform-aws-modules/rds-aurora/aws"

  name           = local.name
  engine         = "aurora-mysql"
  engine_version = "5.7.mysql_aurora.2.10.2"
  instance_class = "db.r6g.large"
  instances = {
    one   = {}
    two   = {}
  }

  autoscaling_enabled      = true
  autoscaling_min_capacity = 1
  autoscaling_max_capacity = 3

  vpc_id                 = aws_vpc.vpc.id
  db_subnet_group_name   = aws_db_subnet_group.database.name
  create_db_subnet_group = false
  create_security_group  = true
  allowed_cidr_blocks    = ["172.31.0.0/16"]

  iam_database_authentication_enabled = true
  master_password                     = "yjkim1!2022#"
  create_random_password              = false

  apply_immediately   = true
  skip_final_snapshot = true

  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]

  security_group_use_name_prefix = false

  tags = local.tags
}
