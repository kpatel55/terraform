variable "project_id" {
  description = "GCP Project ID"
}

variable "region" {
  description = "GCP Region Name"
  default = "us-central1"
}

variable "machine_type" {
  description = "Machine Type for the VM Instance"
  default = "e2-standard-2"
}

variable "subnet_cidr" {
  description = "VPC Subnet IP Range"
  default = "10.0.0.0/24"
}

variable "allow_http_range" {
  description = "HTTP IP Range Allowed"
  default = ["0.0.0.0/0"]
}

variable "allow_ssh_range" {
  description = "SSH IP Range Allowed"
  default = ["35.235.240.0/20"]
}