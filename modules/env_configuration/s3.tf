variable s3_bucket_name {
  type = "string"
}

variable s3_bucket_tags {
  type = "map"
}

module s3_config_bucket {
  source = "../generic/s3"
  s3_bucket_name = "${var.s3_bucket_name}"
  s3_bucket_tags = "${var.s3_bucket_tags}"
}
