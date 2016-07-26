variable publishing_subnet_cidr_block {
  type = "list"
}

variable publishing_subnet_tags {
  type = "map"
}

variable publishing_subnet_availability_zone {
  type = "list"
}

variable publishing_ami_id {
  type = "string"
}

variable publishing_instance_type {
  type = "string"
}

variable publishing_instance_count {
  type = "string"
}

variable publishing_allow_ssh_traffic_from {
  type = "list"
}

variable publishing_public_ip_addr {
  type = "string"
}

variable publishing_non_asg_instance_count {
  type = "string"
}

variable publishing_enable_asg {
  type = "string"
}

module publishing {
  source                   = "../containers/app_subnet"
  subnet_tags              = "${var.publishing_subnet_tags}"
  subnet_availability_zone = ["${var.publishing_subnet_availability_zone}"]
  subnet_cidr_block        = "${var.publishing_subnet_cidr_block}"
  vpc_id                   = "${aws_vpc.main.id}"
  ami_id                   = "${var.publishing_ami_id}"
  instance_type            = "${var.publishing_instance_type}"
  asg_instance_count       = "${var.publishing_instance_count}"
  allow_ssh_traffic_from   = "${var.publishing_allow_ssh_traffic_from}"
  app_security_groups      = ["${aws_security_group.publishing_sg.id}"]
  routing_table            = "${aws_route_table.publishing.id}"
  public_ip_addr_toggle    = "${var.publishing_public_ip_addr}"
  non_asg_instance_count   = "${var.publishing_non_asg_instance_count}"
  enable_asg               = "${var.publishing_enable_asg}"
}
