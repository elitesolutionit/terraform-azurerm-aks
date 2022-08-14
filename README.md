Utilize this module to create multiple aks cluster and cluster pool.

## Module Example Usage

```hcl
/******************
 * RESOURCE GROUP *
 ******************/
resource "azurerm_resource_group" "eliteclusterdemorg" {
  name     = "eliteclusterdemoaks"
  location = "eastus2"
}

/*********************
 * SERVICE PRINCIPAL *
 *********************/
resource "azuread_application" "examplecluster" {
  display_name = "examplecluster"
}

resource "azuread_service_principal" "examplecluster-SP" {
  application_id = azuread_application.examplecluster.application_id
}

resource "azuread_service_principal_password" "examplecluster-SP" {
  service_principal_id = azuread_service_principal.examplecluster-SP.id
}

module "aks" {
  source = "git::https://github.com/ArerepadeBenagha/elite-terraform-azurerm-aks.git?ref=v1.0.0"

  k8s = {
    "examplecluster" = { dns_prefix = "eliteclusterdns",
      client_id     = azuread_service_principal.examplecluster-SP.application_id,
      client_secret = azuread_service_principal_password.examplecluster-SP.value,
      load_balancer_sku = "standard", network_plugin = "kubenet" }

    "examplecluster2" = { dns_prefix = "eliteclusterdns",
      client_id     = azuread_service_principal.examplecluster-SP.application_id,
      client_secret = azuread_service_principal_password.examplecluster-SP.value,
      load_balancer_sku = "standard", network_plugin = "kubenet" }
  }

  subcription_name    = "< your subscription name >"
  env                 = "dev"
  agent_name          = "devagent"
  node_count          = "2"
  vm_size             = "Standard_D2_v2"
  admin_username      = "ubuntu"
  key_data            = "< your - publickey >"

  service_principal = [{
    client_id     = azuread_service_principal.examplecluster-SP.application_id
    client_secret = azuread_service_principal_password.examplecluster-SP.value
  }]

  network_profile = [{
    load_balancer_sku = "standard"
    network_plugin    = "kubenet"
  }]

  depends_on = [azurerm_resource_group.eliteclusterdemorg, azuread_service_principal.examplecluster-SP, azuread_service_principal_password.examplecluster-SP]
}
```

## Documentation Reference
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster