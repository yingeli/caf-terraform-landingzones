module "bastion_pip" {
  count = var.enable_bastion ? 1 : 0
  
  source  = "aztfmod/caf-public-ip/azurerm"
  version = "2.0.0"
  # source = "git://github.com/aztfmod/terraform-azurerm-caf-public-ip?ref=2003-refresh"


  convention                       = var.global_settings.convention 
  name                             = var.bastion_config.ip_name
  location                         = var.location
  resource_group_name              = var.rg
  ip_addr                          = var.bastion_config.ip_addr
  tags                             = var.tags
  diagnostics_map                  = var.caf_foundations_accounting.diagnostics_map
  log_analytics_workspace_id       = var.caf_foundations_accounting.log_analytics_workspace.id
  diagnostics_settings             = var.bastion_config.ip_diags
}

resource "azurerm_bastion_host" "azurebastion" {
  count = var.enable_bastion ? 1 : 0

  name                = var.bastion_config.name
  location            = var.location
  resource_group_name = var.rg
  tags                = var.tags

  ip_configuration {
    name                 = "bastionpipconfiguration"
    subnet_id            = var.subnet_id
    public_ip_address_id = module.bastion_pip.id
  }
}

module "diagnostics_bastion" {
  count = var.enable_bastion ? 1 : 0
    
  source  = "aztfmod/caf-diagnostics/azurerm"
  version = "1.0.0"

    name                            = azurerm_bastion_host.azurebastion.name
    resource_id                     = azurerm_bastion_host.azurebastion.id
    log_analytics_workspace_id      = var.caf_foundations_accounting.log_analytics_workspace.id
    diagnostics_map                 = var.caf_foundations_accounting.diagnostics_map
    diag_object                     = var.bastion_config.diagnostics
}