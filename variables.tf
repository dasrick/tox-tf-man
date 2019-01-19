// application ---------------------------------------------------------------------------------------------------------
variable "application" {
  description = "Name of application (always lowercase)"
  type        = "string"
  default     = "man"
}

variable "environment" {
  description = "Name of the environment (in our case a combi of Account+Environment)"
  type        = "string"
}

// AWS -----------------------------------------------------------------------------------------------------------------
variable "region" {
  description = "AWS - Region"
  type        = "string"
  default     = "eu-west-1"
}

variable "s3-artifacts" {
  description = "S3 bucket to store artifacts (e.g. lambda packages)"
  type        = "string"
}

// Tags ----------------------------------------------------------------------------------------------------------------
variable "tag_environment" {
  description = "TAG - Environment (DEV / STAGING / PROD)"
  type        = "string"
}

variable "tag_pname" {
  description = "TAG - Product name"
  type        = "string"
  default     = "MAN"
}

// locals --------------------------------------------------------------------------------------------------------------
locals {
  name_prefix = "${var.application}-${var.environment}"

  common_tags = {
    Environment = "${var.tag_environment}"
    ProductName = "${var.tag_pname}"
  }
}

// =====================================================================================================================

// lambda versions -----------------------------------------------------------------------------------------------------
variable "man-service-version" {
  description = "Lambdas of MAN services"
  type        = "string"
  default     = "master"                  // poss. names v1-2-3, master, abc-1234
}

// s3 ------------------------------------------------------------------------------------------------------------------
variable "s3_path_incoming" {
  description = "S3 path/prefix for incoming files"
  type        = "string"
  default     = "incoming"
}
