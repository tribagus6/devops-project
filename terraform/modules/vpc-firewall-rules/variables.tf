variable "project_id" {
  description = "The project ID where the firewall rules will be created."
  type        = string
}

variable "network_name" {
  description = "The name of the VPC network to apply the rules to. Must be the name, not self_link."
  type        = string
}

variable "firewall_rules" {
  description = "A map of firewall rules to create. The key of the map is the rule name."
  type = map(object({
    description   = optional(string)
    direction     = optional(string, "INGRESS")
    priority      = optional(number, 1000)
    disabled      = optional(bool, false)
    
    source_ranges      = optional(list(string))
    destination_ranges = optional(list(string))
    
    source_tags         = optional(list(string))
    target_tags         = optional(list(string))
    
    source_service_accounts = optional(list(string))
    target_service_accounts = optional(list(string))

    # A list of allow blocks, e.g., [{ protocol = "tcp", ports = ["22"] }]
    allow = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })), [])

    # A list of deny blocks
    deny = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })), [])

    log_config_metadata = optional(string, "INCLUDE_ALL_METADATA") # Can be "EXCLUDE_ALL_METADATA" or "INCLUDE_ALL_METADATA"
  }))
  default = {}
}