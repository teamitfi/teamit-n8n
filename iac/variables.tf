variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{4,28}[a-z0-9]$", var.project_id))
    error_message = "Project ID must be between 6 and 30 characters, start with a letter, and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "environment" {
  description = "The environment for the infrastructure (e.g., dev, staging, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "region" {
  description = "The region to deploy resources"
  type        = string
  default     = "europe-north1"
  validation {
    condition     = can(regex("^[a-z]+-[a-z]+[0-9]$", var.region))
    error_message = "Region must be a valid GCP region name (e.g., us-central1, europe-west1, europe-north1)."
  }
}

# variable "min_scale" {
#   description = "Minimum number of API instances"
#   type        = number
#   default     = 1
#   validation {
#     condition     = var.min_scale >= 0 && var.min_scale <= 100
#     error_message = "Minimum scale must be between 0 and 100."
#   }
# }

# variable "max_scale" {
#   description = "Maximum number of API instances"
#   type        = number
#   default     = 10
#   validation {
#     condition     = var.max_scale >= 1 && var.max_scale <= 100
#     error_message = "Maximum scale must be between 1 and 100."
#   }
# }

# variable "memory_limit" {
#   description = "Memory limit per API instance"
#   type        = string
#   default     = "1Gi"
#   validation {
#     condition     = can(regex("^[0-9]+(Mi|Gi)$", var.memory_limit))
#     error_message = "Memory limit must be specified in Mi or Gi (e.g., 512Mi, 4Gi)."
#   }
# }

# variable "cpu_limit" {
#   description = "CPU limit per API instance"
#   type        = string
#   default     = "1000m"
#   validation {
#     condition     = can(regex("^[0-9]+m$", var.cpu_limit))
#     error_message = "CPU limit must be specified in millicores (e.g., 1000m)."
#   }
# }

variable "repository_base_id" {
  description = "The base ID of the Artifact Registry repository"
  type        = string
  default     = "ceevee"
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,61}[a-z0-9]$", var.repository_base_id))
    error_message = "Repository base ID must be between 4 and 63 characters, start with a letter, and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "repository_description" {
  description = "Description of the Artifact Registry repository"
  type        = string
  default     = "Container registry for Ceevee applications"
}

variable "n8n_image_tag" {
  description = "The tag for the n8n container image"
  type        = string
  default     = "latest"
  validation {
    condition     = length(var.n8n_image_tag) > 0
    error_message = "Image tag cannot be empty."
  }
}