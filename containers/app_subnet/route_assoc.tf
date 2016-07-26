resource "aws_route_table_association" "publishing_association" {
    count = "${length(var.subnet_cidr_block)}"
    subnet_id = "${element(aws_subnet.main.*.id, count.index)}"
    route_table_id = "${var.routing_table}"
}
