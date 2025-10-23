# Add variable definition for the firewall rules
variable "project_id" {
  description = "The project ID of the host project."
  type        = string
}

variable "firewall_rules" {
  description = "A map of firewall rules to create in the host project."
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

    allow = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })), [])

    deny = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })), [])

    log_config_metadata = optional(string, "INCLUDE_ALL_METADATA") # Can be "EXCLUDE_ALL_METADATA" or "INCLUDE_ALL_METADATA"
  }))
  default = {}
}