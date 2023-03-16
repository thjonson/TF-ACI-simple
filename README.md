# TF-ACI-simple

This is a sample script to demonstrate the basics of what Terraform can do with ACI.  It will create a tenant, AP, VRF and a few EPGs and BDs.  This example reads the standard terraform.tfvars for some variables, and also parses a comma seperated value file whcih some may find easier for entering repetitive data.

After cloning the repository you will need to initialize terraform `terraform init` to download the provider files, and then modify the terraform.tfvars with your ACI IP/URL.

The next step is to plan your deployment with `terraform plan`.  You will be prompted for your APIC password before Terraform can propose the changes needed to meet the declared intent in the main.tf file.  If you prefer you can define your password in the terraform.tfvars file, or better yet define it as an environment varaible which adds a bit of secrecy.

`$export TF_VAR_aci_password=passw0rd123`

If the plan looks good, it is time to deploy with `terraform apply`.  This will run through the plan, wait for you to type `yes` if you wish to proceed with the changes, then make the changes on the APIC.

You can make additional changes by modifying or adding a EPG/BD if you want and reapply the changes.

When complete with your demonstration, run `terraform destroy` to clean up the environment and remove all changes from the APIC.
