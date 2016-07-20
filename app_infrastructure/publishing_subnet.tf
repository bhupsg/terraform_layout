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

module publishing {
  source                   = "../containers/app_subnet"
  subnet_tags              = "${var.publishing_subnet_tags}"
  subnet_availability_zone = ["${var.publishing_subnet_availability_zone}"]
  subnet_cidr_block        = "${var.publishing_subnet_cidr_block}"
  vpc_id                   = "${aws_vpc.main.id}"
  ami_id                   = "${var.publishing_ami_id}"
  instance_type            = "${var.publishing_instance_type}"
}
