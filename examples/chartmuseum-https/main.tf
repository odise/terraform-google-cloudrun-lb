module "upload_bucket" {
  source          = "terraform-google-modules/cloud-storage/google"
  version         = "1.7.2"
  project_id      = var.project_id
  names           = ["cmcr-test"]
  prefix          = ""
  set_admin_roles = true
  bucket_admins = {
    cmcr-test = "serviceAccount:${module.service_accounts.email}"
  }
}

module "service_accounts" {
  source       = "terraform-google-modules/service-accounts/google"
  version      = "~> 3.0"
  project_id   = var.project_id
  prefix       = module.example.suffix
  names        = ["cmcr-sa"]
  display_name = "chartmuseum cloud run service account"
}

module "example" {
  source = "../.."

  project_id       = var.project_id
  region           = "europe-west3"
  ssl              = true
  dns_record_name  = "chartmuseum"
  domain_name      = "sandbox.example.com"
  dns_managed_zone = "sandbox-example-com"
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
  cloud_run_service_name = "chartmuseum-example"
  create_service_account = false
  service_account_email  = module.service_accounts.email
}
