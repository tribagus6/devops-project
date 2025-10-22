output "instance_name" {
  description = "Name of the GCE instance."
  value       = google_compute_instance.main.name
}

output "instance_ip" {
  description = "The internal IP of the GCE instance."
  value       = google_compute_instance.main.network_interface[0].network_ip
}