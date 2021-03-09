terraform {
  required_version = ">=0.13.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.58"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}
