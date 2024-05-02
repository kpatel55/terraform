resource "google_compute_instance" "one-piece-instance" {
  project      = var.project_id
  machine_type = var.machine_type
  name         = "one-piece-instance"

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  metadata = {
    startup-script = file("./files/startup")
  }

  boot_disk {
    auto_delete = true
    device_name = "one-piece-instance"

    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20240426"
      size  = 20
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    queue_count        = 0
    stack_type         = "IPV4_ONLY"
    subnetwork         = google_compute_subnetwork.one-piece-subnet.name
    subnetwork_project = google_compute_subnetwork.one-piece-subnet.project
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  service_account {
    email  = google_service_account.one-piece-sa.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  tags = ["allow-http", "allow-ssh"]
  zone = "${var.region}-a"
}
