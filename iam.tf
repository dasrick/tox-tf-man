locals {
  role_name_man_importer    = "${local.name_prefix}-man-importer"
  role_name_man_transformer = "${local.name_prefix}-man-transformer"
}

// cmd importer --------------------------------------------------------------------------------------------------------
resource "aws_iam_role" "man_importer" {
  name               = "${local.role_name_man_importer}"
  assume_role_policy = "${file("policy/assume-role-policy-lambda.json")}"

  tags = "${merge(local.common_tags, map(
    "Name", local.role_name_man_importer
  ))}"
}

resource "aws_iam_role_policy" "man_importer" {
  name   = "${local.role_name_man_importer}"
  role   = "${aws_iam_role.man_importer.id}"
  policy = "${data.template_file.man_importer.rendered}"
}

data "template_file" "man_importer" {
  template = "${file("policy/policy-man-importer.json")}"

  vars {
    S3_STASH_ARN  = "${aws_s3_bucket.stash.arn}"
    SNS_TOPIC_ARN = "${aws_sns_topic.address_import.arn}"
  }
}

// cmd transformer -----------------------------------------------------------------------------------------------------
resource "aws_iam_role" "man_transformer" {
  name               = "${local.role_name_man_transformer}"
  assume_role_policy = "${file("policy/assume-role-policy-lambda.json")}"

  tags = "${merge(local.common_tags, map(
    "Name", local.role_name_man_transformer
  ))}"
}

resource "aws_iam_role_policy" "man_transformer" {
  name   = "${local.role_name_man_transformer}"
  role   = "${aws_iam_role.man_transformer.id}"
  policy = "${data.template_file.man_transformer.rendered}"
}

data "template_file" "man_transformer" {
  template = "${file("policy/policy-man-transformer.json")}"

  vars {
    SNS_TOPIC_ARN       = "${aws_sns_topic.address_import.arn}"
    DYNAMODB_SOURCE_ARN = "${aws_dynamodb_table.man_source.arn}"
  }
}
