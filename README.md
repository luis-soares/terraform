# terraform

Modules with "-vcenter" were created to deploy virtual machines in VCENTER.

Exec:
terraform init
# Initialize a Terraform working directory

terraform plan -out=plan
# Generate and show an execution plan
# Please, check the execution plan to validate what will be deployed.

terraform apply "plano"
# Builds or changes infrastructure
