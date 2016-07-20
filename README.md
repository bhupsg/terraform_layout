# Example layout for terraform code.

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
(...)
module publishing {
  source                   = "../containers/app_subnet"
  subnet_tags              = "${var.publishing_subnet_tags}"
  subnet_availability_zone = ["${var.publishing_subnet_availability_zone}"]
  subnet_cidr_block        = "${var.publishing_subnet_cidr_block}"
  vpc_id                   = "${aws_vpc.main.id}"
  ami_id                   = "${var.publishing_ami_id}"
  instance_type            = "${var.publishing_instance_type}"
}
``` 
Check __containers/app_subnet__
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
