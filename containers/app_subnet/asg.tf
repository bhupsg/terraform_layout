resource "aws_launch_configuration" "as_conf" {
    name_prefix = "${var.subnet_tags["Environment"]}-${var.subnet_tags["Tier"]}-"
    image_id = "${var.ami_id}"
    instance_type = "${var.instance_type}"
    security_groups = ["${aws_security_group.main_subnet.id}"]
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "main_asg" {
  depends_on = ["aws_launch_configuration.as_conf"]
  name = "asg-${var.subnet_tags["Environment"]}-${var.subnet_tags["Tier"]}"
  availability_zones = "${var.subnet_availability_zone}"
  launch_configuration = "${aws_launch_configuration.as_conf.id}"
  max_size = "${var.subnet_instance_count}"
  min_size = "${var.subnet_instance_count}"
  vpc_zone_identifier = ["${aws_subnet.main.*.id}"]

  tag = {
    key = "Name"
    value = "${var.subnet_tags["Name"]}-${var.subnet_tags["Tier"]}-${var.ami_id}"
    propagate_at_launch = true
  }

  tag = {
    key = "Environment"
    value = "${var.subnet_tags["Environment"]}"
    propagate_at_launch = true
  }
}
