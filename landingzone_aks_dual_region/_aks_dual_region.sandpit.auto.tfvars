aks_resource_groups = {
    region1 = {
        networking      = {
            name        = "rg-sg-aks-cluster1-networking"
            location    = "southeastasia"
        }
        identity        = {
            name        = "rg-sg-aks-cluster1-identity"
            location    = "southeastasia"
        }
        aks             = {
            name        = "rg-sg-aks-cluster1"
            location    = "southeastasia"
        }
        appgateway      = {
            name        = "rg-sg-aks-cluster1-appgw"
            location    = "southeastasia"
        }
    }
    region2 = {
        networking      = {
            name        = "rg-hk-aks-cluster1-networking"
            location    = "eastasia"
        }
        identity        = {
            name        = "rg-hk-aks-cluster1-identity"
            location    = "eastasia"
        }
        aks             = {
            name        = "rg-hk-aks-cluster1"
            location    = "eastasia"
        }
        appgateway      = {
            name        = "rg-hk-aks-cluster1-appgw"
            location    = "eastasia"
        }
    }
    
}

aks_networking = {
    region1 = {
        location                = "southeastasia"
        vnet = {
            name                = "vnet-singapore"
            address_space       = ["10.0.0.0/24"]     
            dns                 = []
        }
        specialsubnets     = { 
            appgw                   = {
                name                = "appgw-aks-cluster1"
                cidr                = "10.0.0.128/25"
                service_endpoints   = []
                nsg_inbound         = []
                nsg_outbound        = []
            }
        }
        subnets = {
            aks                     = {
                name                = "aks-cluster1"
                cidr                = "10.0.0.0/25"
                service_endpoints   = []
                nsg_inbound         = []
                nsg_outbound        = []
            }
        }
    }
    region2 = {
        location                = "eastasia"
        vnet = {
            name                = "vnet-hongkong"
            address_space       = ["10.0.1.0/24"]     
            dns                 = []
        }
        specialsubnets     = {
            appgw                   = {
                name                = "appgw-aks-cluster1"
                cidr                = "10.0.1.128/25"
                service_endpoints   = []
                nsg_inbound         = []
                nsg_outbound        = []
            }
        }
        subnets = {
            aks                     = {
                name                = "aks-cluster1"
                cidr                = "10.0.1.0/25"
                service_endpoints   = []
                nsg_inbound         = []
                nsg_outbound        = []
            }
        }
    }
}

aks_identity = {
    region1 = {
        user_msi    = "msi-clusterdev01sg"      # Max 24 char including prefix (prefix 4 + 1)
        name        = "aks-clusterdev01sg"
        end_date    = "2020-01-01T01:02:03Z"    # To be refactored to Date + Duration
    }
    region2 = {
        user_msi    = "msi-clusterdev01ea"      # Max 24 char including prefix (prefix 4 + 1)
        name        = "aks-clusterdev01ea"
        end_date    = "2020-01-01T01:02:03Z"    # To be refactored to Date + Duration
    }
}

aks_object = {
    region1 = {
        suffix                      = "sg"
        aks_name                    = "aks-cluster1-sg"
        subnet_name                 = "aks-cluster1"
        aks_version                 = "1.12.7"
        vm_user_name                = "aks-king"
        aks_agent_count             = "1"
        aks_agent_vm_size           = "Standard_D4s_v3"
        aks_agent_os_disk_size      = "32"
        aks_dns_service_ip          = "172.17.0.10"      # IP from aks-cluster1 aks_service_cidr
        aks_docker_bridge_cidr      = "172.16.0.1/16"
        aks_service_cidr            = "172.17.0.0/16"
        aks_pod_cidr                = "172.18.0.0/16"
        aks_netPlugin               = "kubenet" 
    }
    region2 = {
        suffix                      = "ea"
        aks_name                    = "aks-cluster1-hk"
        subnet_name                 = "aks-cluster1"
        aks_version                 = "1.12.7"
        vm_user_name                = "aks-king"
        aks_agent_count             = "1"
        aks_agent_vm_size           = "Standard_D4s_v3"
        aks_agent_os_disk_size      = "32"
        aks_dns_service_ip          = "172.20.0.10"     # IP from aks-cluster1 aks_service_cidr
        aks_docker_bridge_cidr      = "172.19.0.1/16"
        aks_service_cidr            = "172.20.0.0/16"
        aks_pod_cidr                = "172.21.0.0/16"
        aks_netPlugin               = "kubenet" 
    }
}

waf_configuration = {
    region1 = {
        gateway_name                    = "app-gw01-sg"
        subnet_name                     = "appgw-aks-cluster1"
        sku_name                        = "WAF_V2"
        sku_tier                        = "WAF_V2"
        capacity_sku                    = 1      
        pip_sku                         = "Standard"    
        pip_allocation                  = "Static"   
        firewall_mode                   = "Prevention"
        rule_set_type                   = "OWASP"
        rule_set_version                = "3.0"
        waf_enabled                     = true
        frontend_port                   = 80
        backend_port                    = 80
        backend_protocol                = "Http"
        request_timeout                 = 5             # in seconds
        cookie_based_affinity           = "Enabled"
        request_routing_rule_rule_type  = "Basic"   
    }
    region2 = {
        gateway_name                    = "app-gw01-hk"
        subnet_name                     = "appgw-aks-cluster1"
        sku_name                        = "WAF_V2"
        sku_tier                        = "WAF_V2"
        capacity_sku                    = 1      
        pip_sku                         = "Standard"    
        pip_allocation                  = "Static"  
        firewall_mode                   = "Prevention"
        rule_set_type                   = "OWASP"
        rule_set_version                = "3.0"
        waf_enabled                     = true
        frontend_port                   = 80
        backend_port                    = 80
        backend_protocol                = "Http"
        request_timeout                 = 5             # in seconds
        cookie_based_affinity           = "Enabled"
        request_routing_rule_rule_type  = "Basic"  
    }
}

aks_diagnostics_settings = {
    log = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
        ["kube-scheduler", true, true, 7],
        ["kube-controller-manager", true, true, 7],
        ["kube-audit", true, true, 7],
        ["kube-apiserver", true, true, 7],
        ["cluster-autoscaler", true, true, 7]
    ]
    metric = [
        ["AllMetrics", true, true, 30],
    ]
}

waf_diagnostics_settings = {
    log = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
        ["ApplicationGatewayAccessLog", true, true, 7],
        ["ApplicationGatewayPerformanceLog", true, true, 7],
        ["ApplicationGatewayFirewallLog", true, true, 7],
    ]
    metric = [
        ["AllMetrics", true, true, 30],
    ]
}