# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "vm_count" {
  default = 3
}

variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
  default = "anhdv29"
}

variable "resource_group_name" {
  description = "Name of resource group"
  default = "Azuredevops"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default = "eastus2"
}

variable "admin_username" {
  description = "The admin username for the VM being created."
  default = "azureuser"
}

variable "admin_password" {
  description = "The password for the VM being created."
  default = "TreAt@1999123"
}

variable "packer_image" {
   
  default = "/subscriptions/481b1dfa-09f6-4305-a978-b656e03d8e84/resourceGroups/Azuredevops/providers/Microsoft.Compute/images/udacityProject1Image1"
}