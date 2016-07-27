variable dhcp_domain {
  type = "string"
}

variable dhcp_tags {
  type = "map"
}

resource "aws_vpc_dhcp_options" "main_dhcp" {
    domain_name = "${var.dhcp_domain}"
    tags        = "${var.dhcp_tags}"
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
    vpc_id          = "${aws_vpc.main.id}"
    dhcp_options_id = "${aws_vpc_dhcp_options.main_dhcp.id}"
}
