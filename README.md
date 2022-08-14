Utilize this module to create multiple aks cluster and cluster pool.

## Module Example Usage

```hcl
module "aks" {
  source = "git::https://github.com/ArerepadeBenagha/elite-terraform-azurerm-aks.git?ref=v1.0.0"

  k8s = {
    "eliteclusterdemodev" = { dns_prefix = "eliteclusterdns",
      client_id     = azuread_service_principal.eliteclusterdemodev-SP.application_id,
      client_secret = azuread_service_principal_password.eliteclusterdemodev-SP.value,
      load_balancer_sku = "standard", network_plugin = "kubenet" }

    "eliteclusterdemodev2" = { dns_prefix = "eliteclusterdns",
      client_id     = azuread_service_principal.eliteclusterdemodev-SP.application_id,
      client_secret = azuread_service_principal_password.eliteclusterdemodev-SP.value,
      load_balancer_sku = "standard", network_plugin = "kubenet" }
  }

  subcription_name    = "EliteSolutionsIT-DEV"
  env                 = "dev"
  agent_name          = "devagent"
  agent_count         = "2"
  vm_size             = "Standard_D2_v2"
  admin_username      = "ubuntu"
  key_data            = "< your - publickey >"

  service_principal = [{
    client_id     = azuread_service_principal.eliteclusterdemodev-SP.application_id
    client_secret = azuread_service_principal_password.eliteclusterdemodev-SP.value
  }]

  network_profile = [{
    load_balancer_sku = "standard"
    network_plugin    = "kubenet"
  }]

  depends_on = [azurerm_resource_group.eliteclusterdemorg, azuread_service_principal.eliteclusterdemodev-SP, azuread_service_principal_password.eliteclusterdemodev-SP]
}
```

## Documentation Reference
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool