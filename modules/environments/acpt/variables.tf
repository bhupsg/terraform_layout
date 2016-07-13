variable s3_bucket_tags {
  type = "map"
  default = {
    Name = "s3-acpt-bucket"
  }
}

variable s3_bucket_name {
  type = "string"
  default = "s3-acpt-bucket"
}

variable vpc_cidr_block {
  type = "string"
  default = "10.10.10.0/24"
}

variable vpc_tags {
  type = "map"
  default = {
    Name = "acpt"
  }
}

variable dhcp_domain {
  type = "string"
  default = "acpt.doman"
}

variable dhcp_tags {
  type = "map"
  default = {
    Name = "acpt-dhcp-options"
  }
}
