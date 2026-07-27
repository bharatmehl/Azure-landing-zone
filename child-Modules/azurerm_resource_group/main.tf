resource "azurerm_resource_group" "rgs" {

for_each = var.rgs
name= eaxh.value.name
location= each.value.location

}
