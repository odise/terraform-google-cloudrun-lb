resource "google_compute_disk" "default" {
  name = var.name
  disk_encryption_key {}
}

variable "name" {}
