# terraform

Modules on folders by providers: 

VCENTER is ok.

AWS and Azure Modules coming soon... =)

https://www.terraform.io/docs/configuration/syntax.html 

https://www.terraform.io/downloads.html Terraform Download

Exec this steps:

# Initialize a Terraform working directory
terraform init

# Generate and show an execution plan
# Please, check the execution plan to validate what will be deployed.
terraform plan -out=plan

# Builds or changes infrastructure
terraform apply "plan"

# If you have problem to customize your Windows Servers, remember that you shouldn't run sysprep on your Operation System, Terraform will do it for you. If the problem of customizing still occurs, check the sysprep log, you may need to resolve sysprep problems. Check this article to resolve the sysprep error:
https://www.wintips.org/fix-sysprep-fatal-error-dwret-31-machine-invalid-state-couldnt-update-recorded-state/
