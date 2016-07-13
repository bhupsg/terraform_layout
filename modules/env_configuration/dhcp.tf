variable dhcp_domain {
  type = "string"
}

variable dhcp_tags {
  type = "map"
}

module vpc_dhcp_options {
  source = "../generic/dhcp"
  dhcp_association_vpc_id = "${module.vpc.vpc_id}"
  dhcp_tags = "${var.dhcp_tags}"
  dhcp_domain = "${var.dhcp_domain}"

}
