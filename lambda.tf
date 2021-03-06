locals {
  lambda_importer    = "${local.name_prefix}-importer"
  lambda_transformer = "${local.name_prefix}-transformer"
}

resource "aws_lambda_function" "importer" {
  s3_bucket     = "${var.s3-artifacts}"
  s3_key        = "${local.s3_key_golang_man}importer.zip"
  function_name = "${local.lambda_importer}"
  role          = "${aws_iam_role.man_importer.arn}"
  handler       = "importer"
  runtime       = "go1.x"
  timeout       = 900
  description   = "S3 => SNS ... timeout: 15min"

  environment = {
    variables = {
      SNS_TOPIC_ARN = "${aws_sns_topic.address_import.arn}"
    }
  }

  tags = "${merge(local.common_tags, map(
    "Name", local.lambda_importer
  ))}"

  //  source_code_hash = "${timestamp()}"
}

resource "aws_lambda_function" "transformer" {
  s3_bucket     = "${var.s3-artifacts}"
  s3_key        = "${local.s3_key_golang_man}transformer.zip"
  function_name = "${local.lambda_transformer}"
  role          = "${aws_iam_role.man_transformer.arn}"
  handler       = "transformer"
  runtime       = "go1.x"
  timeout       = 300
  description   = "SNS => DDB ... timeout: 5min"

  environment = {
    variables = {
      DYNAMODB_SOURCE_NAME = "${aws_dynamodb_table.man_source.name}"
    }
  }

  tags = "${merge(local.common_tags, map(
    "Name", local.lambda_transformer
  ))}"

  //  source_code_hash = "${timestamp()}"
}
