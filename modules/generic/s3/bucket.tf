resource "aws_s3_bucket" "bucket" {
    bucket = "${var.s3_bucket_name}"
    acl = "private"
    tags = "${var.s3_bucket_tags}"
    force_destroy = true
}
