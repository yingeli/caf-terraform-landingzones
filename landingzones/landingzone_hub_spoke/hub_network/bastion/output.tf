output "bastion" {
  depends_on = [azurerm_bastion_host.azurebastion]
  value = var.enable_bastion ? azurerm_bastion_host.azurebastion : null
}
