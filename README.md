# Example layout for terraform code. 

## Principles

### __generic__ module directory
* Provides granularity for basic resources. 
* It will force to set some pieces of configuration fe. tags
* __generic__ direcotry is a set of modules that:
 * have variable definition with defined type (__variables.tf__), at this stage we dont define any environment specific data - no default value allowed, 
 * have nessecary outputs with defined type (__outputs.tf__),
 * is a building block for __"env_configuration"__

### __env_configuration__ module directory
* Here we can define constrains between AWS resoruces. Example: 
```
module dhcp_options {
  source                  = "../generic/dhcp"
  dhcp_association_vpc_id = "${module.vpc.vpc_id}" (1)
  dhcp_tags               = "${var.dhcp_tags}"     (2)
  dhcp_domain             = "${var.dhcp_domain}"   (2)
}
```
This generic module dhcp_options use __output__ information from generic module vpc (1), and information from variables that we pass via __environments__ directory (2).

* Here we can define defaults that are common across all environments
* It is a codebase for all environments - so we are forcing all environments to be the same
* The only resource allowed here is a module from __generic__ directory in order to force consistency in resoruces. 

### __environments__ module directory
* The only resource allowed here is __env_configuration__ module - that will accecpt all the environment specific variables (__variables.tf__). Example: 
```
module env {
  # Source module
  source         = "../../env_configuration"

  # s3 module config
  s3_bucket_name = "${var.s3_bucket_name}"
  s3_bucket_tags = "${var.s3_bucket_tags}"

  # vpc module config
  vpc_tags       = "${var.vpc_tags}"
  vpc_cidr_block = "${var.vpc_cidr_block}"

  # dhcp module config
  dhcp_domain = "${var.dhcp_domain}"
  dhcp_tags = "${var.dhcp_tags}"

}
```
## Directory tree

```
└── modules
    ├── env_configuration
    │   ├── dhcp.tf
    │   ├── s3.tf
    │   └── vpc.tf
    ├── environments
    │   ├── acpt
    │   │   ├── main.tf
    │   │   └── variables.tf
    │   └── ci
    │       ├── main.tf
    │       └── variables.tf
    └── generic
        ├── dhcp
        │   ├── dhcp.tf
        │   └── variables.tf
        ├── s3
        │   ├── bucket.tf
        │   ├── outputs.tf
        │   └── variables.tf
        └── vpc
            ├── outputs.tf
            ├── variables.tf
            └── vpc.tf

9 directories, 16 files
```

terraform remote config \
    -backend=s3 \
    -backend-config="bucket=terraform-management" \
    -backend-config="key=terraform.tfstate" \
    -backend-config="region=eu-west-1"
