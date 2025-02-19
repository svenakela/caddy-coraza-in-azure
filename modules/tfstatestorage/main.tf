module "resourcegroup" {
  source = "../resourcegroup"
  resource_group_name_prefix = "rg-mysuperspecial-statestorage"
}

resource "random_string" "resource_code" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "tf${random_string.resource_code.result}"
  resource_group_name      = module.resourcegroup.resource_group_name
  location                 = module.resourcegroup.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    environment = "infrastructure"
    deployment = "opentofu"
  }
}

/*
  The state storage account is restricted to a specific IP.
  Set your public IP adress to limit access to state files.
*/
resource "azurerm_storage_account_network_rules" "tfstate" {
  storage_account_id    = azurerm_storage_account.tfstate.id
  default_action        = "Deny"
  ip_rules              = ["ADD-YOUR-HOME-OR-OFFICE-PUBLIC-IP-ADDRESS-HERE-FOR-REDUCED-ACCESS"]
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstates"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}
