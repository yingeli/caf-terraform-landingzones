module "aks_region1" {
    source                      = "./blueprint/cafb_aks_with_appgw"

    prefix                      = local.prefix
    resource_groups             = var.aks_resource_groups.region1
    object                      = var.aks_object.region1
    networking                  = var.aks_networking.region1
    identity                    = var.aks_identity.region1
    waf_configuration           = var.waf_configuration.region1

    tags                        = local.tags
    diagnostics_map             = local.diagnostics_map
    log_analytics_workspace     = local.log_analytics_workspace
    aks_diagnostics_settings    = var.aks_diagnostics_settings
    waf_diagnostics_settings    = var.waf_diagnostics_settings
}


