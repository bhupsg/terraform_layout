variable s3_bucket_tags {
  type    = "map"
  default = {
    Name = "s3-fb01-bucket"
  }
  description = "Tagging for s3 bucket"
}

variable vpc_tags {
  type    = "map"
  default = {
    Name = "fb01"
  }
  description = "Tagging for vpc"
}

variable dhcp_tags {
  type    = "map"
  default = {
    Name = "fb01-dhcp-options"
  }
  description = "Tagging for dhcp configuration"
}

variable publishing_subnet_tags {
  type    = "map"
  default = {
    Name        = "fb01-subnet"
    Environment = "fb01"
    Tier        = "publishing"
  }
  description = "Tagging for subnet - good to have Name,Environment and Tier. We are using those tags when we creating resoruces in subnet."
}
