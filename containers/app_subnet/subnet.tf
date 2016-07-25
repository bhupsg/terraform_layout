resource "aws_subnet" "main" {
    count             = "${length(var.subnet_cidr_block)}"
    vpc_id            = "${var.vpc_id}"
    cidr_block        = "${element(var.subnet_cidr_block, count.index)}"
    tags              = "${var.subnet_tags}"
    availability_zone = "${element(var.subnet_availability_zone, count.index)}"
}
