
resource "azurerm_resource_group" "training" {
  name     = "${var.env}-${var.client}-training-india"
  location = var.location
  
}

resource "azurerm_storage_account" "trainingstorage" {
  name                     = var.storagename
  resource_group_name      = azurerm_resource_group.training.name
  location                 = var.location123
  access_tier              = var.access_tier1
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  account_kind             = var.account_kind
}


resource "azurerm_virtual_network" "zomato_nprod_vnet" {
  name                = "${var.env}-${var.client}-zomato-india-vnet"
  resource_group_name = azurerm_resource_group.training.name
  location            = azurerm_resource_group.training.location
  address_space       = var.zomato_nprod_vnet_address_space
  dns_servers         = var.zomato_nprod_vnet_dns_servers
  tags                = var.tags
  
}

resource "azurerm_subnet" "zomato_subnet1_hyd" {
  name                                           = "${var.env}-${var.client}-zomato-india-vnetsubnet"
  address_prefixes                               = var.zomato_subnet1_hyd_address_prefixes
  virtual_network_name                           = azurerm_virtual_network.zomato_nprod_vnet.name
  resource_group_name                            = azurerm_resource_group.training.name
  enforce_private_link_endpoint_network_policies = var.enforce_private_link_endpoint_network_policies
  service_endpoints                              = var.service_endpoints
}

resource "azurerm_network_interface" "zomatovm1_nic" {
  name                = "zomato-nprod-vm1-nic"
  resource_group_name = azurerm_resource_group.training.name
  location            = azurerm_resource_group.training.location
  ip_configuration {
    name                          = "zomato-nprod-vm1-ip"
    subnet_id                     = azurerm_subnet.zomato_subnet1_hyd.id
    private_ip_address_allocation = lookup(var.private_ip_address_allocation, var.location, "Dynamic")
  }
}


resource "azurerm_network_security_group" "zomato_subnet1_nsg1" {
  name                = "zomato-subnet1-nsg"
  resource_group_name = azurerm_resource_group.training.name
  location            = azurerm_resource_group.training.location
}
//azurerm_network_interface.zomatovm1_nic[2].name

resource "azurerm_subnet_network_security_group_association" "subnet1_nsg1_association" {
  network_security_group_id = azurerm_network_security_group.zomato_subnet1_nsg1.id
  subnet_id                 = azurerm_subnet.zomato_subnet1_hyd.id
}

resource "azurerm_network_interface" "zomatovm12_nic" {
  #count = 3
  name                = "zomato-nprod-vm1-nic"
  resource_group_name = azurerm_resource_group.training.name
  location            = azurerm_resource_group.training.location
  ip_configuration {
    name                          = "zomato-nprod-vm1-ip"
    subnet_id                     = azurerm_subnet.zomato_subnet1_hyd.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "zomatovm1" {
  name                = "zomato-vm1"
  resource_group_name = azurerm_resource_group.training.name
  location            = azurerm_resource_group.training.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = random_string.zomatovm1password.result
  network_interface_ids = [azurerm_network_interface.zomatovm12_nic.id]  //[element(azurerm_network_interface.zomatovm1_nic[*].id, 2)] //[element(azurerm_network_interface.zomatovm1_nic[*].id, 2)]
  os_disk {
    name                 = "vmstorageaccount1"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-datacenter-gensecond"
    version   = "latest"
  }
  availability_set_id = null
  tags = var.tags
}

resource "random_string" "zomatovm1password" {
  length           = 12
  special          = true
  min_upper        = 2
  override_special = "@%!-"
  min_lower        = 4
}
















