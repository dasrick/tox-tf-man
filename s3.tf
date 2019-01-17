locals {
  bucket_name_storage = "${local.name_prefix}-stash"
}

// STASH - persist whole data strtucture ===============================================================================
resource "aws_s3_bucket" "stash" {
  bucket        = "${local.bucket_name_storage}"
  acl           = "private"
  region        = "${var.region}"
  force_destroy = true

  versioning {
    enabled = false
  }

  lifecycle {
    prevent_destroy = false
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = "${merge(
      local.common_tags,
      map(
        "Name", local.bucket_name_storage
      )
    )}"
}

resource "aws_s3_bucket_object" "stash_readme_incoming" {
  depends_on   = ["aws_s3_bucket.stash"]
  bucket       = "${aws_s3_bucket.stash.bucket}"
  key          = "${var.s3_path_incoming}/README.md"
  source       = "docs/S3_IMPORT_README.md"
  content_type = "text/markdown"
  etag         = "${md5(file("docs/S3_IMPORT_README.md"))}"
}

resource "aws_s3_bucket_object" "stash_readme_uncompressed" {
  depends_on   = ["aws_s3_bucket.stash"]
  bucket       = "${aws_s3_bucket.stash.bucket}"
  key          = "${var.s3_path_uncompressed}/README.md"
  source       = "docs/S3_UNCOMPRESSED_README.md"
  content_type = "text/markdown"
  etag         = "${md5(file("docs/S3_UNCOMPRESSED_README.md"))}"
}

resource "aws_s3_bucket_notification" "stash_notification_incoming_unzip" {
  depends_on = [
    "aws_s3_bucket.stash",
    "aws_s3_bucket_object.stash_readme_incoming",
    "aws_lambda_function.man_unzip",
  ]

  bucket = "${aws_s3_bucket.stash.id}"

  lambda_function {
    lambda_function_arn = "${aws_lambda_function.man_unzip.arn}"
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "${var.s3_path_incoming}/"
    filter_suffix       = ".zip"
  }
}

resource "aws_s3_bucket_notification" "stash_notification_uncompressed_import" {
  depends_on = [
    "aws_s3_bucket.stash",
    "aws_s3_bucket_object.stash_readme_uncompressed",
    "aws_lambda_function.man_import",
  ]

  bucket = "${aws_s3_bucket.stash.id}"

  lambda_function {
    lambda_function_arn = "${aws_lambda_function.man_import.arn}"
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "${var.s3_path_uncompressed}/"
    filter_suffix       = ".csv"
  }
}
