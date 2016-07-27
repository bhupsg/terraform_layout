resource "aws_security_group" "generic" {
  name        = "ssh-${var.subnet_tags["Name"]}-${var.subnet_tags["Environment"]}"
  description = "SSH security group for ${var.subnet_tags["Name"]}"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "allow_ssh" {
    type              = "ingress"
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks       = ["${var.allow_ssh_traffic_from}"]
    security_group_id = "${aws_security_group.generic.id}"
}

resource "aws_security_group_rule" "out_rule" {
    type              = "egress"
    from_port         = 0
    to_port           = 65535
    protocol          = "all"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.generic.id}"
}
