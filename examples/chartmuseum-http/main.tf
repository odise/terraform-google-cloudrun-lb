terraform {
  required_version = ">=0.13.5"
}

module "upload_bucket" {
  source     = "terraform-google-modules/cloud-storage/google"
  version    = "1.7.2"
  project_id = var.project_id
  names      = ["cmcr-test"]
  prefix     = ""
}

module "example" {
  source = "../.."

  project_id       = var.project_id
  region           = "europe-west3"
  ssl              = false
  dns_record_name  = ""
  domain_name      = ""
  dns_managed_zone = ""
  name             = "cmcr"
  name_suffix      = ""
  lb_name          = "cmcr"
  container_image  = "gcr.io/${var.project_id}/chartmuseum:v0.13.0"
  container_port   = 8080
  container_env = {
    STORAGE               = "google"
    STORAGE_GOOGLE_BUCKET = module.upload_bucket.name
    STORAGE_GOOGLE_PREFIX = ""
  }
  cloud_run_service_name       = "chartmuseum-example"
  create_service_account       = true
  service_account_name         = "cmcr-sa"
  service_account_display_name = "Service account for Chart Museum Cloud Run service"
  service_account_roles        = ["${var.project_id}=>roles/editor"]

  template_metadata_annotations = { generated-by = "magic-modules" }
  labels                        = { my = "label" }
}
