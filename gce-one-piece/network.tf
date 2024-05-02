resource "google_compute_network" "one-piece-vpc" {
  name                    = "one-piece-vpc"
  project                 = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "one-piece-subnet" {
  name          = "one-piece-subnet"
  project       = var.project_id
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.one-piece-vpc.id
}

resource "google_compute_firewall" "allow-http" {
  name        = "allow-http"
  project     = var.project_id
  network     = google_compute_network.one-piece-vpc.name
  description = "Allow http web traffic"

  allow {
    protocol  = "tcp"
    ports     = ["80"]
  }

  source_ranges = var.allow_http_range
  target_tags   = ["allow-http"]
}

resource "google_compute_firewall" "allow-ssh" {
  name        = "allow-ssh"
  project     = var.project_id
  network     = google_compute_network.one-piece-vpc.name
  description = "Allow ssh to vm instance"

  allow {
    protocol  = "tcp"
    ports     = ["22"]
  }

  source_ranges = var.allow_ssh_range
  target_tags   = ["allow-ssh"]
}