module "azurerm_resource_group" {
  source = "../../child-Modules/azurerm_resource_group"
  rgs    = var.rgs

}

module "azurerm_virtual_network" {
  depends_on = [module.azurerm_resource_group]
  source     = "../../child-Modules/azurerm_virtual_network"
  vnets      = var.vnets

}

module "azurerm_subnet" {
  depends_on = [module.azurerm_virtual_network]
  source     = "../../child-Modules/azurerm_subnet"
  subnets    = var.subnets

}

module "azurerm_public_ip" {
  depends_on = [module.azurerm_resource_group]
  source     = "../../child-Modules/azurerm_public_ip"
  pips       = var.pips
}

module "azurerm_bastion" {
  depends_on = [module.azurerm_public_ip, module.azurerm_subnet]
  source     = "../../child-Modules/azure_bastion"
  bastion    = var.bastion

}

module "azurerm_network_card" {
  depends_on = [module.azurerm_resource_group, module.azurerm_subnet]
  source     = "../../child-Modules/azurerm_network_interface_card"
  nics       = var.nics
}

module "azurerm_nsgs" {
  depends_on = [module.azurerm_subnet]
  source     = "../../child-Modules/azurerm_NSG"
  nsgs       = var.nsgs
}

module "azurerm_nsg_association" {
  depends_on = [module.azurerm_nsgs, module.azurerm_subnet]
  source     = "../../child-Modules/azurerm_NSG_association"
  nsgass     = var.nsgass
}

module "azurerm_vms" {
  depends_on = [module.azurerm_network_card]
  source     = "../../child-Modules/azurerm_virtual_machine"
  vms        = var.vms

}

module "azurerm_keyvault" {
  depends_on = [module.azurerm_resource_group]
  source     = "../../child-Modules/azurerm_keyvault"
  keyvault   = var.keyvault

}
