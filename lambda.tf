locals {
  lambda_dummyone = "${local.name_prefix}-dummyone"
  lambda_dummytwo = "${local.name_prefix}-dummytwo"
  lambda_unzip    = "${local.name_prefix}-unzip"
}

resource "aws_lambda_function" "man_dummyone" {
  s3_bucket     = "${var.s3-artifacts}"
  s3_key        = "man-service/${var.man-service-version}/dummyone.zip"
  function_name = "${local.lambda_dummyone}"
  role          = "${aws_iam_role.man_service.arn}"
  handler       = "dummyone"
  runtime       = "go1.x"
  //  timeout       = 300
  //  memory_size   = 128
  description   = "dummy one ..."
  //  environment   = {
  //    variables = {
  //      S3_BUCKET = "${aws_s3_bucket.stash.bucket}"
  //    }
  //  }
  tags          = "${merge(local.common_tags, map(
    "Name", local.lambda_dummyone
  ))}"
}
resource "aws_lambda_function" "man_dummytwo" {
  s3_bucket     = "${var.s3-artifacts}"
  s3_key        = "man-service/${var.man-service-version}/dummytwo.zip"
  function_name = "${local.lambda_dummytwo}"
  role          = "${aws_iam_role.man_service.arn}"
  handler       = "dummytwo"
  runtime       = "go1.x"
  //  timeout       = 300
  //  memory_size   = 128
  description   = "dummy two ..."
  //  environment   = {
  //    variables = {
  //      S3_BUCKET = "${aws_s3_bucket.stash.bucket}"
  //    }
  //  }
  tags          = "${merge(local.common_tags, map(
    "Name", local.lambda_dummytwo
  ))}"
}
resource "aws_lambda_function" "man_unzip" {
  s3_bucket     = "${var.s3-artifacts}"
  s3_key        = "man-service/${var.man-service-version}/unzip.zip"
  function_name = "${local.lambda_unzip}"
  role          = "${aws_iam_role.man_service.arn}"
  handler       = "unzip"
  runtime       = "go1.x"
  timeout       = 300
  //  memory_size   = 128
  description   = "... unzip ..."
  environment   = {
    variables = {
      S3_PATH_INCOMING     = "${var.s3_path_incoming}"
      S3_PATH_UNCOMPRESSED = "${var.s3_path_uncompressed}"
    }
  }
  tags          = "${merge(local.common_tags, map(
    "Name", local.lambda_unzip
  ))}"
}
