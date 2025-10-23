output "host_project_id" {
  description = "The project ID where the Shared VPC Host was deployed."
  value       = var.project_id
}

output "vpc_network_name" {
  description = "The name of the Shared VPC Host Network."
  value       = module.shared_vpc.network_name
}

output "vpc_network_self_link" {
  description = "The self-link of the Shared VPC Host Network."
  value       = module.shared_vpc.network_self_link
}

output "subnet_self_links" {
  description = "A map containing the key (subnet name) and value (subnet self-link) for all created subnetworks."
  # This assumes the module returns an output map named 'subnet_self_links'.
  value       = module.shared_vpc.subnet_self_links
}

output "subnet_ip_cidr_ranges" {
  description = "A map containing the key (subnet name) and value (IP CIDR range) for all created subnetworks."
  # FIX: Pulling CIDR ranges directly from the input variable (var.subnets) 
  # since the module does not expose them under 'subnet_ip_cidr_map'.
  value = { 
    for k, v in var.subnets : k => v.ip_cidr_range 
  }
}