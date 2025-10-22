output "project_id" {
  description = "The project ID of the host project."
  value       = var.project_id
}

output "network_name" {
  description = "The name of the created VPC network."
  value       = google_compute_network.vpc_network.name
}

output "network_self_link" {
  description = "The self-link of the created VPC network."
  value       = google_compute_network.vpc_network.self_link
}

output "subnet_self_links" {
  description = "Map of subnet names to their self-links."
  value = {
    for k, v in google_compute_subnetwork.subnets : k => v.self_link
  }
}
