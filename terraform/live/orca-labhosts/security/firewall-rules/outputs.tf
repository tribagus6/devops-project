# output "all_firewall_rule_configs" {
#   description = "The complete input configuration map for all firewall rules."
#   # This returns the entire var.firewall_rules map containing all rule definitions.
#   value = var.firewall_rules
# }

# output "firewall_rule_target_tags" {
#   description = "A map containing the rule name and the source IP CIDR ranges for each firewall rule."
#   # Iterates over the input variable 'var.firewall_rules' to extract the source ranges.
#   value = { 
#     for k, v in var.firewall_rules : k => v.target_tags
#   }
# }

output "summarized_firewall_rules" {
  description = "A concise summary of the key properties for each firewall rule."
  value = {
    for name, rule in var.firewall_rules : name => {
      description     = rule.description
      direction       = rule.direction
      priority        = rule.priority
      source_ranges   = rule.source_ranges
      target_tags     = rule.target_tags
      allowed_traffic = rule.allow
      denied_traffic  = rule.deny
    }
  }
}

output "network_used" {
  description = "The name of the shared VPC network the firewall rules were applied to."
  value       = data.terraform_remote_state.host_project.outputs.vpc_network_name
}

output "remote_state_host_id" {
  description = "The project ID of the host project from which the network was retrieved."
  value       = data.terraform_remote_state.host_project.outputs.host_project_id
}