resource "aws_route_table" "publishing" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gw.id}"
    }

    tags {
        Name = "internet-gatway-${var.publishing_subnet_tags["Environment"]}-${var.publishing_subnet_tags["Tier"]}"
    }
}
