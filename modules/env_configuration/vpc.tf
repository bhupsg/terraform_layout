variable vpc_tags {
  type = "map"
}

variable vpc_cidr_block {
  type = "string"
}

module vpc {
  source = "../generic/vpc"
  vpc_tags = "${var.vpc_tags}"
  vpc_cidr_block = "${var.vpc_cidr_block}"
}
