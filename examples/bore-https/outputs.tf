output "load_balancer_ip" {
  value = module.example.load_balancer_ip
}

output "suffix" {
  value = module.example.suffix
}

output "dns_name" {
  value = module.example.dns_name
}

output "cloud_run_status" {
  description = "From RouteStatus. URL holds the url that will distribute traffic over the provided traffic targets. It generally has the form https://{route-hash}-{project-hash}-{cluster-level-suffix}.a.run.app"
  value       = module.example.cloud_run_status
}

output "service_account_email" {
  value = module.example.service_account_email
}
