output "project_id" {
  description = "The Project ID where resource is deployed."
  value       = var.project_id
}

output "region" {
  description = "The GCP Region where the resource is deployed."
  value       = var.region
}

output "server_ip" {
  value = "http://${google_compute_instance.one-piece-instance.network_interface.0.access_config.0.nat_ip}"
}