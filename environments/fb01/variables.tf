variable s3_bucket_tags {
  type = "map"
  default = {
    Name = "s3-fb01-bucket"
  }
}

variable vpc_tags {
  type = "map"
  default = {
    Name = "fb01"
  }
}

variable dhcp_tags {
  type = "map"
  default = {
    Name = "fb01-dhcp-options"
  }
}

variable publishing_subnet_tags {
  type = "map"
  default = {
    Name = "fb01-subnet"
    Environment = "fb01"
    Tier = "publishing"
  }
}
