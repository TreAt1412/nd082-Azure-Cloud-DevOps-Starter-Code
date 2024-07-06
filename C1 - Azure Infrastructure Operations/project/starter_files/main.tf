# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "main" {
  name     = "${var.resource_group_name}"
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/22"]
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  tags = {
    owner = "anhdv29"
    Environment = "Production"
  }
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
  
}

resource "azurerm_network_security_group" "internal_nsg" {
  name                = "internal-nsg"
  location             = data.azurerm_resource_group.main.location
  resource_group_name  = data.azurerm_resource_group.main.name
  security_rule {
        name                = "allow-intra-subnet-access"
        priority             = 150   
        direction            = "Inbound"
        access               = "Allow"
        protocol             = "*"  
        source_port_range    = "*"  
        destination_port_range = "*"
        source_address_prefix = "VirtualNetwork"
        destination_address_prefix = "VirtualNetwork" 
    }
    security_rule {
        name                = "deny-from-internet"
        priority             = 100   
        direction            = "Inbound"
        access               = "Deny"
        protocol             = "*"  
        source_port_range    = "*"  
        destination_port_range = "*"
        source_address_prefix = "Internet"
        destination_address_prefix = "VirtualNetwork"
    }
  
}
 

resource "azurerm_network_interface" "main" {
  count = var.vm_count
  name                = "${var.prefix}-nic-${count.index}"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  ip_configuration {
    name                          = "${var.prefix}-ipconfig"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    
  }
  tags = {
    owner = "anhdv29"
    Environment = "Production"
  }
}

resource "azurerm_public_ip" "public_ip" {
  name                = "${var.prefix}-public-ip"
  location             = data.azurerm_resource_group.main.location
  resource_group_name  = data.azurerm_resource_group.main.name
 
  allocation_method = "Static"  # Allocate a static IP address
  tags = {
    owner = "anhdv29"
    Environment = "Production"
  }
}

resource "azurerm_lb" "loadbalancer" {
  name                = "${var.prefix}-lb"
  location             = data.azurerm_resource_group.main.location
  resource_group_name  = data.azurerm_resource_group.main.name
  tags = {
    owner = "anhdv29"
    Environment = "Production"
  }

  frontend_ip_configuration {
    name = "${var.prefix}-frontend-ipconfig-name"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "lbbackend"{
    loadbalancer_id = azurerm_lb.loadbalancer.id
    name = "${var.prefix}-backend-address-pool-name"
}

resource "azurerm_network_interface_backend_address_pool_association" "nibapa" {
  count = var.vm_count
  network_interface_id = azurerm_network_interface.main[count.index].id
  ip_configuration_name = "${var.prefix}-ipconfig"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lbbackend.id
}



resource "azurerm_availability_set" "availability_set" {
  name                = "${var.prefix}-availability-set"
  location             = data.azurerm_resource_group.main.location
  resource_group_name  = data.azurerm_resource_group.main.name
  tags = {
    owner = "anhdv29"
    Environment = "Production"
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  count = "${var.vm_count}"
  name                            = "${var.prefix}-vm-${count.index}"
  resource_group_name             = data.azurerm_resource_group.main.name
  location                        = data.azurerm_resource_group.main.location
  size                            = "Standard_D2s_v3"
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false
  network_interface_ids = [
    element(azurerm_network_interface.main.*.id, count.index)
  ]

  availability_set_id = azurerm_availability_set.availability_set.id

  source_image_id = "${var.packer_image}"

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  tags = {
    owner = "anhdv29"
    Environment = "Production"
  }
}


resource "azurerm_managed_disk" "azurerm_managed_disk" {
  name                = "${var.prefix}-managed-disk"
  resource_group_name             = data.azurerm_resource_group.main.name
  location                        = data.azurerm_resource_group.main.location
  storage_account_type = "Standard_LRS"
  disk_size_gb = 1024 
  create_option = "Empty"  
  tags = {
    owner = "anhdv29"
    Environment = "Production"
  }
}
 