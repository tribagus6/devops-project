resource "google_compute_firewall" "rules" {
  # Create a rule for each entry in the var.firewall_rules map
  for_each = var.firewall_rules

  project     = var.project_id
  network     = var.network_name
  name        = each.key # The name comes from the map key
  description = lookup(each.value, "description", null)
  direction   = lookup(each.value, "direction", "INGRESS")
  priority    = lookup(each.value, "priority", 1000)
  disabled    = lookup(each.value, "disabled", false)

  source_ranges      = lookup(each.value, "source_ranges", null)
  destination_ranges = lookup(each.value, "destination_ranges", null)

  source_tags             = lookup(each.value, "source_tags", null)
  target_tags             = lookup(each.value, "target_tags", null)
  source_service_accounts = lookup(each.value, "source_service_accounts", null)
  target_service_accounts = lookup(each.value, "target_service_accounts", null)

  # Dynamic block to create 'allow' rules if they exist in the object
  dynamic "allow" {
    for_each = lookup(each.value, "allow", [])
    content {
      protocol = allow.value.protocol
      ports    = lookup(allow.value, "ports", null)
    }
  }

  # Dynamic block to create 'deny' rules if they exist in the object
  dynamic "deny" {
    for_each = lookup(each.value, "deny", [])
    content {
      protocol = deny.value.protocol
      ports    = lookup(deny.value, "ports", null)
    }
  }

  # Configure logging for the firewall rule
  log_config {
    metadata = lookup(each.value, "log_config_metadata", "INCLUDE_ALL_METADATA") # Can be "INCLUDE_ALL_METADATA" or "EXCLUDE_ALL_METADATA"
  }
}