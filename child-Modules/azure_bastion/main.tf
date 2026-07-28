data "azurerm_subnet" "subnetdata" {
  for_each             = var.bastion
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "pipdata" {
  for_each            = var.bastion
  name                = each.value.public_ip_name
  resource_group_name = each.value.resource_group_name
}


resource "azurerm_bastion_host" "AzureBastionSubnet" {

  for_each            = var.bastion
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.subnetdata[each.key].id
    public_ip_address_id = data.azurerm_public_ip.pipdata[each.key].id
  }
}

