variable s3_bucket_tags {
  type = "map"
  default = {
    Name = "s3-ci-bucket"
  }
}

variable s3_bucket_name {
  type = "string"
  default = "s3-ci-bucket"
}

variable vpc_cidr_block {
  type = "string"
  default = "10.10.11.0/24"
}

variable vpc_tags {
  type = "map"
  default = {
    Name = "ci"
  }
}

variable dhcp_domain {
  type = "string"
  default = "ci.doman"
}

variable dhcp_tags {
  type = "map"
  default = {
    Name = "ci-dhcp-options"
  }
}
