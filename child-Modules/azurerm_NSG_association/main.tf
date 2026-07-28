data "azurerm_subnet" "subnetdata" {
  for_each             = var.nsgass
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_network_security_group" "nsgdata" {
  for_each            = var.nsgass
  name                = each.value.nsg_name
  resource_group_name = each.value.resource_group_name
}


resource "azurerm_subnet_network_security_group_association" "nsgass" {
  for_each                  = var.nsgass
  subnet_id                 = data.azurerm_subnet.subnetdata[each.key].id
  network_security_group_id = data.azurerm_network_security_group.nsgdata[each.key].id
}
