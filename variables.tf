variable "subcription_name" {
  type        = string
  description = "Main Subscription for deployments"
}

variable "env" {
  type        = string
  description = "Tier for deployments"

  validation {
    condition     = lower(var.env) == var.env
    error_message = "Please tiers must all be in lower case."
  }
}

variable "agent_name" {
  type = string
  description = "The name which should be used for the default Kubernetes Node Pool. Changing this forces a new resource to be created"
}

variable "node_count" {
  description = "The initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000 and between min_count and max_count."
  type = string
}

variable "vm_size" {
  type = string
  description = "The size of the Virtual Machine, such as Standard_DS2_v2. Changing this forces a new resource to be created."
}

variable "admin_username" {
  description = "The Admin Username for the Cluster. Changing this forces a new resource to be created."
  type = string
}

variable "key_data" {
  description = "The Public SSH Key used to access the cluster. Changing this forces a new resource to be created."
  type = string
}

variable "resource_group_name" {
  type = string
  description = "Specifies the Resource Group where the Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created."
}


variable "service_principal" {
  description = "block supports the following:"
  type = list(object({
    client_id     = string
    client_secret = string
  }))
}

variable "network_profile" {
  description = "block supports the following:"
  type = list(object({
    load_balancer_sku = string
    network_plugin    = string
  }))
}

variable "k8s" {
  description = "Managed Kubernetes Cluster to create. Changing this forces a new resource to be created."
  type        = map(any)
  default = {}
}