module "service_accounts" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "~> 3.0"
  project_id    = var.project_id
  prefix        = module.example.suffix
  names         = ["bore-sa"]
  project_roles = ["${var.project_id}=>roles/editor", "${var.project_id}=>roles/iam.serviceAccountTokenCreator"]
  display_name  = "boring registry cloud run service account"
}

module "upload_bucket" {
  source     = "terraform-google-modules/cloud-storage/google"
  version    = "1.7.2"
  project_id = var.project_id
  names      = ["boring-registry-example"]
  prefix     = ""
}

module "example" {
  source = "../.."

  project_id       = var.project_id
  region           = "europe-west3"
  ssl              = true
  dns_record_name  = "bore"
  domain_name      = "sandbox.example.com"
  dns_managed_zone = "sandbox-example-com"
  name             = "bore"
  name_suffix      = ""
  lb_name          = "bore"
  container_image  = var.container_image
  container_port   = 5601
  container_env = {
    BORING_REGISTRY_GCS_BUCKET           = module.upload_bucket.name
    BORING_REGISTRY_TYPE                 = "gcs"
    BORING_REGISTRY_DEBUG                = true
    BORING_REGISTRY_GCS_SIGNEDURL        = true
    BORING_REGISTRY_GCS_SIGNEDURL_EXPIRY = 30
    BORING_REGISTRY_GCS_SA_EMAIL         = module.service_accounts.email
  }
  cloud_run_service_name = "boring-registry-example"
  service_account_email  = module.service_accounts.email
}
