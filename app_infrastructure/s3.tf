variable s3_bucket_name {
  type = "string"
}

variable s3_bucket_tags {
  type = "map"
}

resource "aws_s3_bucket" "bucket" {
    bucket        = "${var.s3_bucket_name}"
    acl           = "private"
    tags          = "${var.s3_bucket_tags}"
    force_destroy = true
}
