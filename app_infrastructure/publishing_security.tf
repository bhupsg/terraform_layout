resource "aws_security_group" "publishing_sg" {
  name = "publishing-${var.publishing_subnet_tags["Environment"]}"
  description = "Main security group for ${var.publishing_subnet_tags["Name"]}"
  vpc_id = "${aws_vpc.main.id}"
}
