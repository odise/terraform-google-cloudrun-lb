output "load_balancer_ip" {
  description = "External IP of the created load balancer"
  value       = module.lb.external_ip
}

output "suffix" {
  description = "Random ID used for LB, Cloud Run service and NEG naming"
  value       = random_id.suffix.hex
}

output "dns_name" {
  description = "DNS name which points to the created load balancer"
  value       = var.domain_name == "" || var.dns_record_name == "" || var.dns_managed_zone == "" ? "" : "${local.dns_record_name}${var.domain_name}"
}

output "cloud_run_status" {
  description = "From RouteStatus. URL holds the url that will distribute traffic over the provided traffic targets. It generally has the form https://{route-hash}-{project-hash}-{cluster-level-suffix}.a.run.app"
  value       = google_cloud_run_service.service.status
}

output "service_account_email" {
  description = "Email address of the IAM service account associated with the revision of the service"
  value       = google_cloud_run_service.service.template[0].spec[0].service_account_name
}
