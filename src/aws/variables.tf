variable "GHES_NAME" {
  type        = string
  description = "GHES: Name of the instance (e.g. my-ghes-instance)"
}

variable "GHES_HOSTNAME" {
  type        = string
  description = "GHES: Hostname of the instance without 'https://' (e.g. my-ghes-instance.com)"
}

variable "AWS_REGION" {
  type        = string
  description = "AWS: Region for OIDC Resources"
  default     = "eu-north-1"
}

variable "AWS_OIDC_THUMBPRINT" {
  type        = string
  description = "AWS: Thumbprint of the GHES Instance for OIDC"
}

variable "AWS_STS_ENDPOINT" {
  type        = string
  description = "AWS: URL of the STS endpoint to use as audience for OIDC"
}
