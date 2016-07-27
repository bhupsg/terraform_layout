variable subnet_cidr_block {
  type        = "list"
  description = "List of cird blocks eg. [\"10.10.10.0/24\", \"10.10.11.0/24\"]"
}

variable subnet_tags {
  type        = "map"
  description = "Tagging for subnets"
}

variable subnet_availability_zone {
  type        = "list"
  description = "List of avability zones eg. [\"eu-west-1a\",\"eu-west-1b\",\"eu-west-1c\"]"
}

variable vpc_id {
  type        = "string"
  description = "VPC ID - all subnets are attached to VPC"
}

variable ami_id {
  type        = "string"
  description = "AMI ID - what AMI you want to use in order to launch instances in subnet"
}

variable instance_type {
  type        = "string"
  description = "What size of instance you want to have"
}

variable asg_instance_count {
  type        = "string"
  description = "Desired number of instnaces in ASG"
}

variable allow_ssh_traffic_from {
  type        = "list"
  description = "List of IP that you want to allow for SSH communication"
}

variable app_security_groups {
  type        = "list"
  description = "List of sg attached to instance in subnet"
}

variable routing_table {
  type        = "string"
  description = "Routing table for subnets"
}

variable public_ip_addr_toggle {
  type        = "string"
  description = "Toggle that enable or disable public addr for instances in a subnet"
}

variable ssh_key_name {
  type        = "string"
  default     = "deployer-key"
  description = "Deployment key for instances"
}

variable enable_asg {
  type        = "string"
  default     = "1"
  description = "By default "
}

variable non_asg_instance_count {
  type    = "string"
  default = "0"
}
