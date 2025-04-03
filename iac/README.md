# Infrastructure as Code

This directory contains the infrastructure configuration for N8N. Due to historical reasons,  
there are some refereces to CV, but the repo and IaC relate to N8N and its related services used at Teamit.

## Overview

The infrastructure is managed using Terraform and consists of GCP resources needed to run the application.

## Structure

```text
iac/
├── main.tf          # Main Terraform configuration
├── providers.tf     # Provider configurations
├── variables.tf     # Input variables
├── outputs.tf       # Output definitions
└── modules/
    ├── vpc/                 # Network configuration
    ├── artifact-registry/   # Container registry
    ├── cloud-sql/          # Database instance
    ├── cloud-run-api/      # API service
    └── cloud-run-n8n/      # N8N automation service
```

## Prerequisites

- Terraform >= 1.0
- Google Cloud SDK
- GCP Service Account with appropriate permissions
- GCS bucket for Terraform state (defined in providers.tf)

## Resources Created

- VPC network with serverless VPC access
- Cloud Run services for API and N8N
- Cloud SQL PostgreSQL instance
- Artifact Registry for container images
- Cloud Load Balancing (Cloud Run default)
- IAM service accounts and permissions
- Secret Manager for sensitive data

## Modules

- **vpc**: Network infrastructure with serverless VPC connector
- **artifact-registry**: Container registry for storing application images
- **cloud-sql**: PostgreSQL database instance
- **cloud-run-api**: Main API service deployment
- **cloud-run-n8n**: N8N workflow automation service

## Usage

> **Note:** Local infrastructure deployment should only be used for testing purposes. 
> Production infrastructure changes should be deployed through the CI/CD pipeline.

1. Initialize Terraform:

```bash
terraform init
```

2. Review planned changes:

```bash
terraform plan
```

## State Management

Terraform state is stored remotely in a Google Cloud Storage bucket with state locking via Cloud Storage.

## Security

- All sensitive resources are deployed in private subnets
- IAM and VPC firewall rules control access between components
- Encryption at rest is enabled for Cloud SQL and Cloud Storage

## Input Variables and Validation

### Required Variables

- `project_id`: Must be 6-30 characters, start with letter, only lowercase letters/numbers/hyphens
- `environment`: Must be one of: "dev", "staging", "prod"
- `api_domain_name`: Must be a valid FQDN
- `api_image`: Non-empty container image URL
- `image_tag`: Non-empty container image tag

### Optional Variables with Defaults

- `region`: Valid GCP region (default: "europe-north1")
- `min_scale`: 0-100 instances (default: 1)
- `max_scale`: 1-100 instances (default: 10)
- `memory_limit`: Format: "&lt;number&gt;Mi|Gi" (default: "1Gi")
- `cpu_limit`: Format: "&lt;number&gt;m" (default: "1000m")
- `repository_base_id`: 4-63 chars, lowercase alphanumeric with hyphens (default: "ceevee")

## Formatting and validation

The codebase follows standard Terraform formatting conventions. Before committing, run:

```bash
# Format all Terraform files recursively
terraform fmt --recursive

# Validate the configuration
terraform validate
```

For CI/CD pipelines, it's recommended to fail the build if either command returns a non-zero exit code.

## Infrastructure Setup

### Configuration

1. Copy the example variables file:

```bash
cp example.tfvars terraform.tfvars
```

2. Edit `terraform.tfvars` with your actual values. This file is gitignored for security.

3. The variables file might contain sensitive configuration and is not tracked in git. Make sure to securely share the actual values with team members.
