# Example layout for terraform code.

## Principles

### __env_configuration__ module directory
* Here we can define constrains between AWS resoruces. Example:
```
variable dhcp_domain {
  type = "string"
}

variable dhcp_tags {
  type = "map"
}

resource "aws_vpc_dhcp_options" "main_dhcp" {
    domain_name = "${var.dhcp_domain}" (2)
    tags = "${var.dhcp_tags}" (2)
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
    vpc_id = "${aws_vpc.main.id}" (1)
    dhcp_options_id = "${aws_vpc_dhcp_options.main_dhcp.id}"
}
```
This generic dhcp options resource. We use information from vpc resource (1), and information from variables that we pass via __environments__ directory (2).

* It will force to set some pieces of configuration fe. tags
* Here we can define defaults that are common across all environments
* It is a codebase for all environments - so we are forcing all environments to be the same
* The only resource allowed here is a module from __generic__ directory in order to force consistency in resoruces.

### __environments__ module directory
* The only resource allowed here is __env_configuration__ module - that will accecpt all the environment specific variables (__variables.tf__). Example:
```
module env {
  # Source module
  source                              = "../../app_infrastructure"
  # s3 module config
  s3_bucket_name                      = "s3-fb01-bucket"
  s3_bucket_tags                      = "${var.s3_bucket_tags}"
  # vpc module config
  vpc_tags                            = "${var.vpc_tags}"
  vpc_cidr_block                      = "10.10.0.0/16"
  # dhcp module config
  dhcp_domain                         = "fb01.doman"
  dhcp_tags                           = "${var.dhcp_tags}"
  # subnet configuration
  publishing_subnet_cidr_block        = ["10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24"]
  publishing_subnet_tags              = "${var.publishing_subnet_tags}"
  publishing_subnet_availability_zone = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  publishing_ami_id                   = "ami-408c7f28"
  publishing_instance_type            = "t1.micro"
}
```
## Directory tree

```
├── app_infrastructure
│   ├── dhcp.tf
│   ├── publishing_subnet.tf
│   ├── s3.tf
│   └── vpc.tf
├── containers
│   └── app_subnet
│       ├── asg.tf
│       ├── subnet.tf
│       └── variables.tf
└── environments
    └── fb01
        ├── main.tf
        └── variables.tf
```

terraform remote config \
    -backend=s3 \
    -backend-config="bucket=terraform-management" \
    -backend-config="key=terraform.tfstate" \
    -backend-config="region=eu-west-1"
