resource "aws_instance" "instance" {
  count = "${var.non_asg_instance_count}"
  ami = "${var.ami_id}"
  instance_type = "${var.instance_type}"

  associate_public_ip_address = "${var.public_ip_addr_toggle}"
  vpc_security_group_ids = ["${aws_security_group.generic.id}", "${var.app_security_groups}"]
  subnet_id = "${element(aws_subnet.main.*.id, count.index)}"
  availability_zone = "${element(var.subnet_availability_zone, count.index)}"
  key_name = "${var.ssh_key_name}"

  tags {
    Name = "${var.subnet_tags["Name"]}-${var.subnet_tags["Tier"]}-${var.ami_id}-${count.index}"
    Environment = "${var.subnet_tags["Environment"]}"
    Tier = "${var.subnet_tags["Tier"]}"
  }
}
