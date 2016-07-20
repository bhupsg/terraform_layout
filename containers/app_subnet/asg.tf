resource "aws_launch_configuration" "as_conf" {
    name_prefix = "${var.subnet_tags["Environment"]}-${var.subnet_tags["Tier"]}-"
    image_id = "${var.ami_id}"
    instance_type = "${var.instance_type}"
    lifecycle {
        create_before_destroy = true
    }
}

/*resource "aws_autoscaling_group" "main_asg" {
  depends_on                = ["aws_launch_configuration.launch_config"]
  name                      = "ASG-${var.publishing_subnet_tags["Environment"]}-${var.publishing_subnet_tags["publishing"]}"
  availability_zones        = ["${split(",", var.availability_zones)}"]
  vpc_zone_identifier       = ["${split(",", var.vpc_zone_subnets)}"]
  launch_configuration      = "${aws_launch_configuration.launch_config.id}"
  max_size                  = "${var.asg_number_of_instances}"
  min_size                  = "${var.asg_minimum_number_of_instances}"
  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "${var.health_check_type}"
  lifecycle {
      create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.asg_name}-${var.ami_id}"
    propagate_at_launch = true
  }
  tag {
    key                 = "environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }
  tag {
    key                 = "LC"
    value               = "${var.asg_name}-${var.ami_id}"
    propagate_at_launch = false
  }
  tag {
    key                 = "AMI"
    value               = "${var.ami_id}"
    propagate_at_launch = false
  }
}*/
