variable subnet_cidr_block {
  type = "list"
}

variable subnet_tags {
  type = "map"
}

variable subnet_availability_zone {
  type = "list"
}

variable vpc_id {
  type = "string"
}

variable ami_id {
  type = "string"
}

variable instance_type {
  type = "string"
}

variable subnet_instance_count {
  type = "string"
}

variable allow_ssh_traffic_from {
  type = "list"
}

/*variable app_security_group {
  type = "string"
}*/
