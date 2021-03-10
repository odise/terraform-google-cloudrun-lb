# variable "project_id" {
#   description = "GCP project ID to use"
#   type        = string
# }

# variable "region" {
#   description = "Location for load balancer and Cloud Run resources"
#   type        = string
#   default     = "europe-west3"
# }

# variable "ssl" {
#   description = "Run load balancer on HTTPS and provision managed certificate with provided `domain`"
#   type        = bool
#   default     = true
# }

# variable "additional_managed_ssl_certificate_domains" {
#   description = "Additional DNS records to be included in the certificate chain"
#   type        = list(string)
#   default     = []
# }

# variable "dns_record_name" {
#   description = "Record name of the `domain_name` parameter pointing at the load balancer on (e.g. `registry`). Used if `ssl` is `true`"
#   type        = string
#   default     = ""
# }

# variable "domain_name" {
#   description = "Domain name to run the load balancer on (e.g. example.com). Used if `ssl` is `true`"
#   type        = string
#   default     = ""
# }

# variable "dns_managed_zone" {
#   description = "Name of the Google managed zone the DNS record will be created in"
#   type        = string
#   default     = ""
# }

# variable "name" {
#   description = "Name which will be used as a part of NEG name"
#   type        = string
#   default     = "cr"
# }

# variable "name_suffix" {
#   description = "Add a name suffix to relevant Terraform resources"
#   type        = string
#   default     = ""
# }

# variable "lb_name" {
#   description = "Name for load balancer and associated resources"
#   type        = string
#   default     = "cr-lb"
# }

# variable "container_image" {
#   description = "Container image to use, eg. `gcr.io/my-project/my-image:latest`. Image needs to be stored either in Google Container Registry or Google Artifact Registry"
#   type        = string
# }

# variable "container_env" {
#   description = "Map of environment variables that will be passed to the container"
#   type        = map(string)
#   default     = null
# }

# variable "container_port" {
#   description = "TCP port to open in the container"
#   type        = number
#   default     = 8080
# }

# variable "cloud_run_service_name" {
#   description = "Name for the Cloud Run service"
#   type        = string
# }

# variable "service_account_email" {
#   description = "Email address of the IAM service account associated with the revision of the service. The service account represents the identity of the running revision, and determines what permissions the revision has. If not provided and `create_service_account` is set to `false`, the revision will use the project's default service account (PROJECT_NUMBER-compute@developer.gserviceaccount.com). Ignored if `create_service_account` is set to `true`"
#   type        = string
#   default     = null
# }

# variable "create_service_account" {
#   description = "Whether to create a new service account associated with the revision of the service"
#   type        = bool
#   default     = false
# }

# variable "service_account_name" {
#   description = "Name of the service account to create. Used only if `create_service_account` is set to `true`"
#   type        = string
#   default     = "cr-sa"
# }

# variable "service_account_display_name" {
#   description = "Display name for the created service account. Used only if `create_service_account` is set to `true`"
#   type        = string
#   default     = "Cloud Run service account"
# }

# variable "service_account_roles" {
#   description = "List of permissions set to the service account to be created. E.g. `[\"project_id=>roles/editor\"]`."
#   type        = list(string)
#   default     = []
# }
