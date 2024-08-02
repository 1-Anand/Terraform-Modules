variable "resource_groups" {
  type = map(any)
  description = "Map of resource groups"
}

variable "virtual_networks" {
  type = map(any)
  description = "Map of virtual networks"
}

variable "subnets" {
  type = map(any)
  description = "Map of subnets"
}