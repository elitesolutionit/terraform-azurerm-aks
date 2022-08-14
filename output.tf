output "resource_group_name" {
  value = data.azurerm_resource_group.rg.name
}

output "client_key" {
  value = azurerm_kubernetes_cluster.k8s.client_key
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.k8s.client_certificate
}


output "cluster_username" {
  value = azurerm_kubernetes_cluster.k8s.username
}

output "cluster_password" {
  value = azurerm_kubernetes_cluster.k8s.password
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.k8s.client_certificate
}
