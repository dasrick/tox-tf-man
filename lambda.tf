locals {
  lambda_unzip  = "${local.name_prefix}-unzip"
  lambda_import = "${local.name_prefix}-import"
}

resource "aws_lambda_function" "man_unzip" {
  s3_bucket     = "${var.s3-artifacts}"
  s3_key        = "man-service/${var.man-service-version}/unzip.zip"
  function_name = "${local.lambda_unzip}"
  role          = "${aws_iam_role.man_unzip.arn}"
  handler       = "unzip"
  runtime       = "go1.x"
  timeout       = 300

  //  memory_size   = 128
  description = "... unzip ..."

  environment = {
    variables = {
      S3_PATH_INCOMING     = "${var.s3_path_incoming}"
      S3_PATH_UNCOMPRESSED = "${var.s3_path_uncompressed}"
    }
  }

  tags = "${merge(local.common_tags, map(
    "Name", local.lambda_unzip
  ))}"

  source_code_hash = "${timestamp()}"
}

resource "aws_lambda_function" "man_import" {
  s3_bucket     = "${var.s3-artifacts}"
  s3_key        = "man-service/${var.man-service-version}/import.zip"
  function_name = "${local.lambda_import}"
  role          = "${aws_iam_role.man_import.arn}"
  handler       = "import"
  runtime       = "go1.x"
  timeout       = 300

  //  memory_size   = 512
  description = "... import ..."

  environment = {
    variables = {
      S3_PATH_INCOMING     = "${var.s3_path_incoming}"
      S3_PATH_UNCOMPRESSED = "${var.s3_path_uncompressed}"
      S3_PATH_PROCESSED    = "${var.s3_path_processed}"
    }
  }

  tags = "${merge(local.common_tags, map(
    "Name", local.lambda_import
  ))}"

  source_code_hash = "${timestamp()}"
}
