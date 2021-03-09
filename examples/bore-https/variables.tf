variable "project_id" {
  description = "GCP project ID to use"
  type        = string
}

variable "container_image" {
  description = "URI of the container image to use (needs to be stored stored either in Google Container Registry or Google Artifact Registry)"
  type        = string
}
