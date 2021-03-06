/**
 * # Google Cloud Run deployment module
 *
 * Configurable module to:
 *
 * * create a Cloud Run service based on the provided container image
 * * create a load balancer for the Cloud Run service and (optionally) a DNS record pointing to that load balancer
 * 
 */

locals {
  name_suffix     = var.name_suffix == "" ? "" : "-${var.name_suffix}"
  dns_record_name = var.dns_record_name == "" ? "" : "${var.dns_record_name}."
}

resource "random_id" "suffix" {
  byte_length = 2
  prefix      = "cr"
}

module "service_account" {
  count = var.create_service_account ? 1 : 0

  source        = "terraform-google-modules/service-accounts/google"
  version       = "~> 3.0.0"
  project_id    = var.project_id
  prefix        = random_id.suffix.hex
  names         = [var.service_account_name]
  project_roles = var.service_account_roles
  display_name  = var.service_account_display_name
}

module "lb" {
  source  = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"
  version = "~> 4.5.0"

  name    = "${var.lb_name}-${random_id.suffix.hex}"
  project = var.project_id

  ssl                             = var.ssl
  managed_ssl_certificate_domains = compact(concat(["${local.dns_record_name}${var.domain_name}"], var.additional_managed_ssl_certificate_domains))
  https_redirect                  = var.ssl

  backends = {
    default = {
      description = null
      groups = [
        {
          group = google_compute_region_network_endpoint_group.serverless_neg.id
        }
      ]
      enable_cdn             = false
      security_policy        = null
      custom_request_headers = null

      iap_config = {
        enable               = false
        oauth2_client_id     = ""
        oauth2_client_secret = ""
      }
      log_config = {
        enable      = var.lb_backend_log_config_enable
        sample_rate = var.lb_backend_log_config_enable ? var.lb_backend_log_config_sample_rate : null
      }
    }
  }
}

resource "google_compute_region_network_endpoint_group" "serverless_neg" {
  name                  = "${var.name}${local.name_suffix}-serverless-neg-${random_id.suffix.hex}"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  project               = var.project_id
  cloud_run {
    service = google_cloud_run_service.service.name
  }
}

resource "google_cloud_run_service" "service" {
  name     = "${var.cloud_run_service_name}-${random_id.suffix.hex}"
  location = var.region
  project  = var.project_id

  template {
    spec {
      containers {
        image = var.container_image
        dynamic "env" {
          for_each = var.container_env != null ? var.container_env : {}
          content {
            name  = env.key
            value = env.value
          }
        }
        ports {
          container_port = var.container_port
        }
        resources {
          limits = {
            cpu    = "${var.container_resources_limits_cpus * 1000}m"
            memory = "${var.container_resources_limits_memory}Mi"
          }
        }
      }
      service_account_name = var.create_service_account ? module.service_account[0].email : var.service_account_email
    }
    metadata {
      labels      = var.labels
      annotations = var.template_metadata_annotations
    }
  }
}


resource "google_cloud_run_service_iam_member" "public_access" {
  location = google_cloud_run_service.service.location
  project  = google_cloud_run_service.service.project
  service  = google_cloud_run_service.service.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_dns_record_set" "dns_record" {
  count   = var.domain_name == "" || var.dns_record_name == "" || var.dns_managed_zone == "" ? 0 : 1
  project = var.dns_record_project_id == "" ? var.project_id : var.dns_record_project_id
  name    = "${local.dns_record_name}${var.domain_name}."
  type    = "A"
  ttl     = 300

  managed_zone = var.dns_managed_zone

  rrdatas = [module.lb.external_ip]
}
