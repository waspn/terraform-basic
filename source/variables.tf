variable "bucket_name" {
  type    = string
  default = "S3_BUCKET_NAME"
}

variable "bucket_key" {
  type    = string
  default = "S3_STATE_FILE.tfstate"
}

variable "bucket_region" {
  type    = string
  default = "REGION"
}

variable "provider_credential" {
  type    = string
  default = "CREDENTIAL_PATH/.credential"
}

variable "provider_profile" {
  type    = string
  default = "CREDENTIAL_PROFILE_NAME"
}

variable "provider_region" {
  type    = list(string)
  default = ["REG_1", "REG_2"]
}
