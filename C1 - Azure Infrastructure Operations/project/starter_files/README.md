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
   
    **az policy definition create --name tagging-policy --display-name "deny-creation-if-untagged-resources" --description "This policy will deny creation of any resource that has no tagged" --rules "policy.json" --mode All**
   ![create policy](https://github.com/TreAt1412/nd082-Azure-Cloud-DevOps-Starter-Code/assets/37327111/99f0d3e8-081e-47ca-8af6-44341e0373f5)

4. Run below command to assign policy
   
    **az policy assignment create --policy tagging-policy  --name tagging-policy --display-name "deny-creation-if-untagged-resources"**
   ![assign policy](https://github.com/TreAt1412/nd082-Azure-Cloud-DevOps-Starter-Code/assets/37327111/60dc6fa9-181e-43cf-9ba1-587fdf81528c)

6. Check whether policy is assign with below command and view result
   
    **az policy assignment list**
   ![result policy 1](https://github.com/TreAt1412/nd082-Azure-Cloud-DevOps-Starter-Code/assets/37327111/90d44d3b-84b1-4826-944c-c98119d35c9f)
   ![result policy 2](https://github.com/TreAt1412/nd082-Azure-Cloud-DevOps-Starter-Code/assets/37327111/321a69f6-a2a2-4099-acc2-0e73337c52ee)
   ![result policy 3](https://github.com/TreAt1412/nd082-Azure-Cloud-DevOps-Starter-Code/assets/37327111/b443103d-0b1d-4e87-82f5-e02d78adcc99)


Step 3: Build Image with Packer
1. Upload file server.json to Azure Bash Shell
2. Replace credentials with the ones provided in Udacity lab 
3. Run below command to create Image with Packer
   
    **packer build server.json**
   ![packer build success](https://github.com/TreAt1412/nd082-Azure-Cloud-DevOps-Starter-Code/assets/37327111/905b9601-ff28-4849-b023-28adae0ed7da)

4. Check whether image is created successfully
   
    **az image list**
   ![az image list](https://github.com/TreAt1412/nd082-Azure-Cloud-DevOps-Starter-Code/assets/37327111/7ce85ef8-4508-4420-a291-ffad03f6a49a)
 
   
Step 4: Create Infrastructure with Terraform
1. Upload file main.tf and variable.tf to Azure Bash Shell
2. Run below command to check terraform plan
   
    **terraform plan**
   ![terraform plan](https://github.com/TreAt1412/nd082-Azure-Cloud-DevOps-Starter-Code/assets/37327111/cbff7592-c3df-4922-b21e-7b75d77a5c39)

3. Run below command to create resources with terraform
   
    **terraform apply**
   ![terraform apply](https://github.com/TreAt1412/nd082-Azure-Cloud-DevOps-Starter-Code/assets/37327111/c82522b2-d857-47d5-8e23-704e681a105f)

4. View result
   ![terraform apply 2](https://github.com/TreAt1412/nd082-Azure-Cloud-DevOps-Starter-Code/assets/37327111/a0c55a71-533e-45f8-8dac-9ef668ab0fc6)

5. Delete all resource after create
   
    **terraform destroy**
    ![terraform destroy](https://github.com/TreAt1412/nd082-Azure-Cloud-DevOps-Starter-Code/assets/37327111/3cbcc63e-5fd6-4cab-bb0f-abd92c46ddce)
 

