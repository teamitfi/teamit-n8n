# Teamit N8N Infrastructure

This repository contains infrastructure as code (IaC) and related services for Teamit's n8n automation platform. It was originally forked from the Ceevee repository, which was planned to focus on Teamit's CV management system. However, this repository has been repurposed to focus solely on n8n and its supporting infrastructure.

## Repository Structure

```text
.
├── docs/               # Documentation files
├── iac/                # Infrastructure as Code
└── .github/           # GitHub Actions workflows
```

## Features

- IaC using Terraform
- Google Cloud Platform infrastructure setup:
  - Cloud Run services for n8n and related services
  - Cloud SQL PostgreSQL instance with databases and users
  - VPC networking with private connectivity
  - Artifact Registry for container images
  - Comprehensive IAM and security configuration
  - Secret Manager for sensitive data management
- CI/CD pipelines using GitHub Actions with:
  - Pull request validation
  - Environment-specific deployments (development/staging/production)
  - Workload Identity Federation for secure GCP authentication

## Prerequisites

- Google Cloud Platform project
- GitHub repository access
- Terraform >= 1.11.0
- Google Cloud SDK

## Setup

1. Follow the authentication setup guide in [docs/gcp-auth-setup.md](docs/gcp-auth-setup.md)
2. Configure GitHub repository variables as specified in the workflows:
   - PROJECT_ID
   - PROJECT_NUMBER
   - WIF_SERVICE_ACCOUNT
   - GCS_BUCKET (for Terraform state)
   - Other environment-specific variables
3. Copy `example.tfvars` to create your environment-specific variables

## Deploying Changes

1. Make infrastructure changes in the `iac/` directory and create a new directory in the root of the repo if there is need for application code
2. Create a pull request to trigger IaC validation workflow
3. Once approved, merge to main
4. Use the manual "Terraform CD" workflow to deploy to specific environments
