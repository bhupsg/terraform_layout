

terraform remote config \
    -backend=s3 \
    -backend-config="bucket=terraform-management" \
    -backend-config="key=terraform.tfstate" \
    -backend-config="region=eu-west-1"
