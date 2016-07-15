provider "aws" {
    region = "eu-west-1"
}

module env {
  # Source module
  source         = "../../env_configuration"

  # s3 module config
  s3_bucket_name = "s3-fb01-bucket"
  s3_bucket_tags = "${var.s3_bucket_tags}"

  # vpc module config
  vpc_tags       = "${var.vpc_tags}"
  vpc_cidr_block = "10.10.0.0/16"

  # dhcp module config
  dhcp_domain = "fb01.doman"
  dhcp_tags = "${var.dhcp_tags}"

  # subnet configuration
  subnet_cidr_block = "10.10.10.0/24"
  subnet_tags = "${var.subnet_tags}"
  subnet_availability_zone = "eu-west-1a"

}
