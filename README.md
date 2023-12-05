# tf-ghes-oidc
Terraform configuration to setup cloud resources for OpenID Connect (OIDC) on GitHub Enterprise Server (GHES).

Configuring cloud resources to utilize Actions on GHES with OIDC can be a lengthy and challenging task due to stringent security demands that necessitate precise configuration. This repository, although not intended for production purposes, includes Terraform configurations necessary for creating resources across the top three enterprise cloud services: Azure, Amazon Web Services (AWS), and Google Cloud Platform (GCP).

## Requirements

To utilize this repository, the following are required:

- Terraform (see [installation guide](https://developer.hashicorp.com/terraform/install))
- A project set up on either Azure, AWS, or Google Cloud for resource creation.

## Usage

To deploy the resources, follow these steps:

1. Install the relevant cloud CLI by executing one of the scripts in the `scripts/` directory: `azure-cli.sh`, `aws-cli.sh`, or `gcp-cli.sh`.
1. Refresh the console profile file (such as `~/.bashrc`) to enable the use of the CLI without requiring the full path.
1. Initialize the chosen cloud CLI and authenticate with your cloud provider.
1. Run `terraform init` to initialize Terraform and install necessary dependencies.
1. The default Terraform `backend` is set to `local`, meaning Terraform state is stored locally. This can be altered to any supported backend.
1. Navigate to the `src` directory.
1. Change the name of `terraform.tfvars.example` to `terraform.tfvars` and modify the variables to suit your setup. The `terraform.tfvars` file holds the configuration for the Terraform files.
1. Execute `terraform plan -out=oidc.plan` to prepare for resource creation. This plan is saved in the `oidc.plan` file for the next step.
1. Use `terraform apply oidc.plan` to initiate the creation of the resources.
1. The configuration necessary for enabling Actions on GHES with OIDC in the GHES Management Console is provided at the conclusion of the process, as dictated by the outputs specified in `src/outputs.tf`.
1. Additional instructions specific to each cloud provider are detailed further below.

> Note: If you're just experimenting with Actions on GHES with OIDC, use `terraform destroy` to delete all resources created by Terraform to prevent unwanted expenses.

Useful Information: This repository's configuration is verified through a GitHub Action in `.github/terraform.yml`, which ensures its accuracy.

## Cloud Providers

### Azure

### AWS

### Google Cloud

Before initiating resource creation in a Google Cloud project, you should follow these preparatory steps:

1. Make sure that the project is linked to a [Billing Account](https://cloud.google.com/billing/docs/how-to/manage-billing-account).
2. Execute `gcloud init` to start the Google Cloud CLI and choose the project where you plan to deploy the resources.
3. Run `gcloud auth application-default login` for authenticating the CLI with Google Cloud.
4. Modify the `GCP_PROJECT_ID` variable in the `terraform.tfvars` file to match the ID of your chosen Google Cloud project for resource deployment.

The required resources for Google Cloud are detailed in the `src/gcp.tf` file. The configuration essential for configuring Actions on GHES with OIDC in the Management Console is produced as outputs: `gcp_service_url`, `gcp_bucket_name`, `gcp_workload_identity_provider_id`, and `gcp_service_account`.
