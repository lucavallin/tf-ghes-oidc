provider "aws" {
  region                   = local.aws_region
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
}
provider "random" {}
