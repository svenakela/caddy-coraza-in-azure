resource "random_pet" "rg_name" {
  # Prefix combined with a random ID making sure the name is unique in your Azure subscription.
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
  tags = {
    environment = "infrastructure"
    deployment = "opentofu"
  }
}
