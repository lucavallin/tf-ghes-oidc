# tf-ghes-oidc
Terraform configuration to setup cloud resources for OpenID Connect (OIDC) on GitHub Enterprise Server (GHES).

Configuring cloud resources to utilize Actions on GHES with OIDC can be a lengthy and challenging task due to stringent security demands that necessitate precise configuration. This repository, although not intended for production purposes, includes Terraform configurations necessary for creating resources across the top three enterprise cloud services: Azure, Amazon Web Services (AWS), and Google Cloud Platform (GCP).

This Terraform configuration is designed to be executed by an individual user, rather than by a Service Account, who is logged into their chosen cloud provider through the corresponding CLI on Linux.

## Requirements

To make use of this repository, you need to have a project or a similar setup on either Azure, AWS, or Google Cloud, specifically for creating resources.

Additionally, you need access to the GHES instance, both through its user interface and over SSH. Make sure your SSH keys are properly set up in the GHES Management Console to ensure this access.

## Usage

To deploy the resources, follow these steps:

1. Install Terraform and the cloud provider CLIs by executing the `scripts/install.sh` script. If needed, refresh the console profile file (such as `~/.bashrc`) to enable the use of the CLI without requiring the full path.
1. Initialize the (chosen) cloud CLI(s) and authenticate with your cloud provider(s).
1. Navigate to the `src/<cloud_provider>` directory.
1. Run `terraform init` to initialize Terraform and install necessary dependencies.
1. The default Terraform `backend` is set to `local`, meaning Terraform state is stored locally. This can be altered to any supported backend.
1. Change the name of `terraform.tfvars.example` to `terraform.tfvars` and modify the variables to suit your setup. The `terraform.tfvars` file holds the configuration for the Terraform files.
1. Execute `terraform plan -out=plan` to prepare for resource creation. This plan is saved in the `plan` file for the next step.
1. Use `terraform apply plan` to initiate the creation of the resources.
1. The configuration necessary for enabling Actions on GHES with OIDC in the GHES Management Console is provided at the conclusion of the process, as dictated by the outputs specified in `src/<cloud_provider>/outputs.tf`.
1. Additional instructions specific to each cloud provider are detailed further below.

> Note: If you're just experimenting with Actions on GHES with OIDC, use `terraform destroy` to delete all resources created by Terraform to prevent unwanted expenses.

Useful Information: This repository's configuration is verified through a GitHub Action in `.github/terraform.yml`, which ensures its accuracy.

## Variables

The Terraform setup requires values for the variables listed in `src/<cloud_provider>/variables.tf`. The file `terraform.tfvars.example` serves as a guide. By renaming `terraform.tfvars.example` to `terraform.tfvars`, you can supply the necessary information as follows:

- `GHES_NAME`: Name of the GHES instance (e.g. my-ghes-instance)
- `GHES_HOSTNAME`: URL of the GHES instance without 'https://' (e.g. my-ghes-instance.com)
- `AZURE_SUBSCRIPTION_ID`: ID of the Azure Subscription to use
- `AZURE_REGION`: Region for the Azure Storage Account (defaults to `West Europe`)
- `AZURE_STORAGE_ACCOUNT_TIER`: Tier for the Azure Storage Account (defaults to `Standard`)
- `AZURE_STORAGE_ACCOUNT_REPLICATION_TYPE`: Replication Type for Azure Storage Account (defaults to `LRS`)
- `AWS_REGION`: AWS Region for OIDC Resources (defaults to `eu-north-1`)
- `AWS_OIDC_THUMBPRINT`: Thumbprint of the GHES Instance to for OIDC setup on AWS
- `GCP_PROJECT_ID`: ID of the Google Cloud Project to use
- `GCP_REGION`: Google Cloud Region for OIDC Resources (defaults to `EUROPE-WEST4`)

## Cloud Providers

### Azure

Prior to starting resource creation in Azure, follow these preliminary steps:

1. Ensure the availability of an Azure subscription for your use.
2. Execute `az login --use-device-code` to authenticate with Azure.
3. If the specific Azure subscription you wish to use is not already active, set it using `az account set --subscription="SUBSCRIPTION_ID"`.
4. Modify the `AZURE_SUBSCRIPTION_ID` variable in the `terraform.tfvars` file to match the ID of your chosen Azure subscription for resource deployment.

The required resources for Azure are detailed in the `src/azure/main.tf` file. The configuration essential for configuring Actions on GHES with OIDC in the Management Console is produced as outputs: `azure_tenant_id`, `azure_client_id`, `azure_storage_account_name`, and `azure_blob_endpoint_suffix`.

### AWS

To set up the resources on AWS, you need to follow these steps:

1. In AWS, create a set of `Access Keys` for your account. You can find this in the `Security Credentials` section ([see the documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html)).
2. Run the `aws configure` command and enter the `Access Keys` you just created. This step links the AWS CLI with your AWS account and creates the `~/.aws/config` and `~/.aws/credentials` files required by the Terraform AWS provider.
3. Create a new Thumbprint for your GHES instance as outlined in the [documentation](https://docs.github.com/en/enterprise-server@3.10/admin/github-actions/enabling-github-actions-for-github-enterprise-server/enabling-github-actions-with-amazon-s3-storage#1-create-an-amazon-oidc-provider). This Thumbprint is necessary for the OIDC setup.

This repository also provides the `scripts/thumbprint.sh` script which generates the Thumbprint. Use it as follows:

```bash
# ./scripts/thumbprint.sh <GHES_HOSTNAME>
$ ./scripts/thumbprint.sh my-ghes-instance.example.com
$ GHES Thumbprint: AB1234567890ABCDEF1234567890ABCDEF123456 # Thumbprint
```

1. Update the `AWS_REGION`, `AWS_STS_ENDPOINT` and `AWS_OIDC_THUMBPRINT` variables in the `terraform.tfvars` file. Set them to your chosen AWS region for deploying resources and the Thumbprint of the GHES instance for the OIDC setup. `AWS_STS_ENDPOINT` can be set to `sts.amazonaws.com` unless you are testing custom STS endpoints.

The required resources for AWS are detailed in the `src/aws/main.tf` file. The configuration essential for configuring Actions on GHES with OIDC in the Management Console is produced as outputs: `aws_s3_bucket`, `aws_role` and `aws_region`.


### Google Cloud

Before initiating resource creation in a Google Cloud project, you should follow these preparatory steps:

1. Make sure that the project is linked to a [Billing Account](https://cloud.google.com/billing/docs/how-to/manage-billing-account).
2. Execute `gcloud init` to start the Google Cloud CLI and choose the project where you plan to deploy the resources.
3. Run `gcloud auth application-default login` for authenticating the CLI with Google Cloud.
4. Modify the `GCP_PROJECT_ID` variable in the `terraform.tfvars` file to match the ID of your chosen Google Cloud project for resource deployment.

The required resources for Google Cloud are detailed in the `src/gcp/main.tf` file. The configuration essential for configuring Actions on GHES with OIDC in the Management Console is produced as outputs: `gcp_service_url`, `gcp_bucket_name`, `gcp_workload_identity_provider_id`, and `gcp_service_account`.
