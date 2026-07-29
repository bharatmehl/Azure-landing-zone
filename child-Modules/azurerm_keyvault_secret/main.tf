data "azurerm_key_vault" "vaultdata" {
  for_each            = var.vaultsecrets
  name                = each.value.key_vault_name
  resource_group_name = each.value.resource_group_name
}


resource "azurerm_key_vault_secret" "key" {
  for_each     = var.vaultsecrets
  name         = each.value.keyname
  value        = each.value.value
  key_vault_id = data.azurerm_key_vault.vaultdata[each.key].id
}
