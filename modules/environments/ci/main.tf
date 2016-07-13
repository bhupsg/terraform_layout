provider "aws" {
    region = "eu-west-1"
}

module env {
  # Source module
  source         = "../../env_configuration"

  # s3 module config
  s3_bucket_name = "${var.s3_bucket_name}"
  s3_bucket_tags = "${var.s3_bucket_tags}"

  # vpc module config
  vpc_tags       = "${var.vpc_tags}"
  vpc_cidr_block = "${var.vpc_cidr_block}"

  # dhcp module config
  dhcp_domain = "${var.dhcp_domain}"
  dhcp_tags = "${var.dhcp_tags}"

}
