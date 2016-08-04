# Example layout for terraform code.

## Warning!
* We are using terraform 0.7 - at the moment there is only RC version
* We are using nested modules that are bugged: https://github.com/hashicorp/terraform/issues/5870 (this layout is allowing that - but it is not obligatory)

## Done
* VPC definition
* s3 bucket for tf state
* dhcp configuration
* Subnet container
  * routing table support
  * public ip toggle
  * sg support
  * subnet tagging
  * subnet AZ support
  * instance count for ASG and static 
  * allow ssh from list of hosts

## Plans
* RDS support
* Support for management env
* IAM resources
* Multi AWS account support
* Module outputs

## Basic setup
* create ssh key pair 
```
ssh-keygen -f aws_key
```
* paste content of public key to __app_infrastructure/keypair.tf__
* Enter the env directory:
```
cd environments/fb01
terraform get
terraform plan
```


## Directory tree
```
├── app_infrastructure
│   ├── dhcp.tf
│   ├── keypair.tf
│   ├── publishing_elb.tf
│   ├── publishing_routing.tf
│   ├── publishing_security.tf
│   ├── publishing_subnet.tf
│   ├── s3.tf
│   └── vpc.tf
├── containers
│   └── app_subnet
│       ├── asg.tf
│       ├── ec2_instance.tf
│       ├── outputs.tf
│       ├── route_assoc.tf
│       ├── security.tf
│       ├── subnet.tf
│       └── variables.tf
└── environments
    └── fb01
        ├── main.tf
        └── variables.tf

```

## Principles

### __app_infrastructure__ module directory
* Here we can define constrains between AWS resoruces. Example:
```
(...)
resource "aws_vpc_dhcp_options" "main_dhcp" {
    domain_name = "${var.dhcp_domain}"                                      (2)
    tags        = "${var.dhcp_tags}"
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
    vpc_id          = "${aws_vpc.main.id}"                                  (1)
    dhcp_options_id = "${aws_vpc_dhcp_options.main_dhcp.id}"
}
```
In order to setup DHCP we use information from vpc resource (1), and information from variables that we pass via __app_infrastructure__ directory (2).

* It will force to set some pieces of configuration fe. tags
* Here we can define defaults that are common across all environments
* It is a codebase for all environments - so we are forcing all environments to be the same
* Bigger pices of configuration we can encapsulate into another module. For example publishing tier subnet with nodes, asg, elb etc. 
```
module publishing {
  source                   = "../containers/app_subnet"
  subnet_tags              = "${var.publishing_subnet_tags}"
  subnet_availability_zone = ["${var.publishing_subnet_availability_zone}"]
  subnet_cidr_block        = "${var.publishing_subnet_cidr_block}"
  vpc_id                   = "${aws_vpc.main.id}"
  ami_id                   = "${var.publishing_ami_id}"
  instance_type            = "${var.publishing_instance_type}"
  asg_instance_count       = "${var.publishing_instance_count}"
  allow_ssh_traffic_from   = "${var.publishing_allow_ssh_traffic_from}"
  app_security_groups      = ["${aws_security_group.publishing_sg.id}"]
  routing_table            = "${aws_route_table.publishing.id}"
  public_ip_addr_toggle    = "${var.publishing_public_ip_addr}"
  non_asg_instance_count   = "${var.publishing_non_asg_instance_count}"
  enable_asg               = "${var.publishing_enable_asg}"
}
``` 
Check __containers/app_subnet__.
### __environments__ module directory
* The only resource allowed here is __app_infrastructure__ module - that will accecpt all the environment specific variables (__variables.tf__ for complex type - like maps). Example:
```
module env {
  # Source module
  source                              = "../../app_infrastructure"
  
  s3_bucket_name                      = "s3-fb01-bucket"
  s3_bucket_tags                      = "${var.s3_bucket_tags}"
  
  vpc_tags                            = "${var.vpc_tags}"
  vpc_cidr_block                      = "10.10.0.0/16"
  
  dhcp_domain                         = "fb01.doman"
  dhcp_tags                           = "${var.dhcp_tags}"
  
  publishing_subnet_cidr_block        = ["10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24"]
  publishing_subnet_tags              = "${var.publishing_subnet_tags}"
  publishing_subnet_availability_zone = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  publishing_ami_id                   = "ami-4cdd453f"
  publishing_instance_type            = "t1.micro"
  publishing_instance_count           = "0"
  publishing_enable_asg               = "0"
  publishing_allow_ssh_traffic_from   = ["10.10.5.0/24"]
  publishing_public_ip_addr           = "true"
  publishing_non_asg_instance_count   = "0"
}
```

terraform remote config \
    -backend=s3 \
    -backend-config="bucket=terraform-management" \
    -backend-config="key=terraform.tfstate" \
    -backend-config="region=eu-west-1"
