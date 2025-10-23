output "rule_names" {
  description = "A list of the created firewall rule names."
  value       = keys(google_compute_firewall.rules)
}

output "rule_self_links" {
  description = "A map of the firewall rule names to their self-links."
  value = {
    for k, v in google_compute_firewall.rules : k => v.self_link
  }
}