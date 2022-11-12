
resource "aws_autoscaling_group" "simple_asg" {
  name = "${aws_launch_configuration.simple_asg.name}-asg"

  min_size             = 2
  desired_capacity     = 2
  max_size             = 4

  health_check_type    = "ELB"
  load_balancers = [
    aws_elb.elb.id
  ]

  launch_configuration = aws_launch_configuration.simple_asg.name

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"

  vpc_zone_identifier  = [
    aws_subnet.public_subnet_a.id,
    aws_subnet.public_subnet_c.id
  ]

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "simple_asg"
    propagate_at_launch = true
  }

}