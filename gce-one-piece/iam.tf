resource "google_service_account" "one-piece-sa" {
  account_id   = "one-piece"
  project      = var.project_id
  display_name = "one-piece-gce"
}