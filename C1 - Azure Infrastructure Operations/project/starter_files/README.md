# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Introduction
For this project, you will write a Packer template and a Terraform template to deploy a customizable, scalable web server in Azure.

### Getting Started
1. Clone this repository

2. Create your infrastructure as code

3. Update this README to reflect how someone would use your code.

### Dependencies
1. Create an [Azure Account](https://portal.azure.com) 
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Instructions
Step 1: Login to Azure
1. Use credentials provided by Udacity Lab to login to Azure portal
2. Access Azure Power Shell in Azure portal to do further step
Step 2: Create policy
1. Upload file policy.json to Azure Bash shell to create policy
2. Run below command to create policy definition
    az policy definition create --name tagging-policy --display-name "deny-creation-if-untagged-resources" --description "This policy will deny creation of any resource that has no tagged" --rules "policy.json" --mode All
3. Run below command to assign policy
    az policy assignment create --policy tagging-policy  --name tagging-policy --display-name "deny-creation-if-untagged-resources"
4. Check whether policy is assign with below command and view result
    az policy assignment list    

Step 3: Build Image with Packer
1. Upload file server.json to Azure Bash Shell
2. Run below command to create Image with Packer
    packer build server.json
3. Check whether image is created successfully
    az image list
4. View result
Step 4: Create Infrastructure with Terraform
1. Upload file main.tf and variable.tf to Azure Bash Shell
2. Run below command to check terraform plan
    terraform plan
3. Run below command to create resources with terraform
    terraform apply
4. View result
5. Delete all resource
    terraform destroy

### Output
**Your words here**

