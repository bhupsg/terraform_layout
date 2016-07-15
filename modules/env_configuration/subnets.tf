variable subnet_cidr_block {
  type = "string"
}

variable subnet_tags {
  type = "map"
}

variable subnet_availability_zone {
  type = "string"
}

resource "aws_subnet" "subnet" {
    vpc_id = "${var.vpc_cidr_block}"
    cidr_block = "${var.subnet_cidr_block}"
    tags = "${var.subnet_tags}"
    availability_zone = "${var.subnet_availability_zone}"
}
