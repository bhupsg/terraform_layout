resource "aws_vpc_dhcp_options" "main_dhcp" {
    domain_name = "${var.dhcp_domain}"
    tags = "${var.dhcp_tags}"
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
    vpc_id = "${var.dhcp_association_vpc_id}"
    dhcp_options_id = "${aws_vpc_dhcp_options.main_dhcp.id}"
}
