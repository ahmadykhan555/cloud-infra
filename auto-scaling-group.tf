# Configure scaling
resource "aws_autoscaling_group" "cc-music-player" {
  name = "${aws_launch_configuration.cc-music-player.name}-asg"

  min_size             = 1
  desired_capacity     = 1
  max_size             = 3
  
  health_check_type    = "ELB"
  load_balancers = [
    aws_elb.music-player-load-balancer.id
  ]

  launch_configuration = aws_launch_configuration.cc-music-player.name

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"

  vpc_zone_identifier  = [
    aws_subnet.subnet-1.id,
    aws_subnet.subnet-2.id
  ]

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "cc-music-player"
    propagate_at_launch = true
  }

}