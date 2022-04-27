variable "swiggy_resource_group_name" {
  description = "Name of the Resource group"
  type        = string
  default     = "prod-swiggy-australia"
}

variable "resource_group_name" {
  description = "Name of the Resource group"
  type        = string
  default     = "southindia"
}

variable "location_resource_group" {
  description = "location for the resource group"
  type        = string
  default     = "eastus2"
}

variable "avinash" {
  description = "value for disabling password"
  type        = bool
  default     = false
}
variable "prefix" {
  description = "prefix value"
  type        = string
  default     = "swiggy"
}

variable "env" {
  type = string
  default = "prod"
}

variable "client" {
  type = string
  default = "inter"
}

variable "country" {
  type = string
  default = "srilanka"
}



//Storage Accounts 
//*****************************************************************************
variable "storage_acc_stor1" {
  description = "Specifies the name of the storage account"
  type        = string
  default     = "accstor1"
}

variable "storagename" {
  
}

variable "storage_acc_stor2" {
  description = "Specifies the name of the storage account"
  type        = string
  default     = "accstor2"
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists"
  type        = string
  default     = "canadacentral"
}

variable "location123" {
  description = "Specifies the supported Azure location where the resource exists"
  type        = string
}

variable "access_tier" {
  description = "Defines the Tier to use for this storage account"
  type        = string
  default     = "hot"
}

variable "access_tier1" {
  description = "Defines the Tier to use for this storage account"
  type        = string
}


variable "vm_size" {
  default = "Standard_B1s"
}

variable "admin_username" {
  default = "itadminlogin"
}

variable "account_tier" {
  description = "value"
  type        = string

}
variable "account_replication_type" {
  type    = string

}

variable "account_replication_type2" {
  type    = string
  default = "LRS"
}

variable "account_kind" {
  type    = string

}

variable "account_kind1" {
  type    = string
  default = "StorageV2"
}

variable "windows_vm_nic" {
  description = "Specify the VM nic to be assigned"
  type        = string
  default     = "/subscriptions/278fa703-5540-44c0-ba9a-d64ea3bb2711/resourceGroups/prod-swiggy1-srilanka/providers/Microsoft.Network/networkInterfaces/zomato-nic-second"
}

//*****************************************************************************

//Azure Vnet Variables
//*****************************************************************************
variable "zomato_nprod_vnet_name" {
  description = "(Required) The name of the virtual network. Changing this forces a new resource to be created."
  default = "zomato-nprod-vnet"
}
variable "zomato_nprod_vnet_address_space" {
  type    = list(string)
  default = ["192.168.0.0/24", "172.165.0.0/24"]
}
variable "zomato_nprod_vnet_dns_servers" {
  description = "value"
  type        = list(string)
  default = []
}
variable "tags" {
  description = ""
  type = map(string)
  default = {
    name = "vnet-avinash"
    project = "nprod"
    billingcode = "7400056846"
}
}

//Azure Vnet subnet Variables
//*****************************************************************************
variable "zomato_subnet1_hyd_name" {
  description = "value"
  type        = string
  default = "zomato-nprod-hyd-vms"
}
variable "zomato_subnet1_hyd_address_prefixes" {
  description = "value"
  type        = list(string)
  default = [ "192.168.0.0/28" ]
}
variable "enforce_private_link_endpoint_network_policies" {
  description = "value"
  type        = bool
  default = false
}
variable "service_endpoints" {
  description = ""
  type        = list(string)
  default = ["Microsoft.Sql", "Microsoft.Web", "Microsoft.KeyVault"]
}

/*
SET TF_VAR_location=brazilsouth
//export TF_VAR_location=brazilsouth
SET TF_VAR_resource_group_name=cloud-shell-storage-southeastasia

*/

variable "private_ip_address_allocation" {
  description = "(Required) specify the private ip address allocation"
  type = map(string)
  default = {
    "eastus" = "Dynamic"
    "westus" = "Static"
  }
}