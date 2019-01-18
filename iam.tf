locals {
  role_name_man_unzip  = "${local.name_prefix}-man-unzip"
  role_name_man_import = "${local.name_prefix}-man-import"
}

// cmd unzip -----------------------------------------------------------------------------------------------------------
resource "aws_iam_role" "man_unzip" {
  name               = "${local.role_name_man_unzip}"
  assume_role_policy = "${file("policy/assume-role-policy-lambda.json")}"

  tags = "${merge(local.common_tags, map(
    "Name", local.role_name_man_unzip
  ))}"
}

resource "aws_iam_role_policy" "man_unzip" {
  name   = "${local.role_name_man_unzip}"
  role   = "${aws_iam_role.man_unzip.id}"
  policy = "${data.template_file.man_unzip.rendered}"
}

data "template_file" "man_unzip" {
  template = "${file("policy/policy-man-unzip.json")}"

  vars {
    S3_STASH_ARN = "${aws_s3_bucket.stash.arn}"
  }
}

// cmd import ----------------------------------------------------------------------------------------------------------
resource "aws_iam_role" "man_import" {
  name               = "${local.role_name_man_import}"
  assume_role_policy = "${file("policy/assume-role-policy-lambda.json")}"

  tags = "${merge(local.common_tags, map(
    "Name", local.role_name_man_import
  ))}"
}

resource "aws_iam_role_policy" "man_import" {
  name   = "${local.role_name_man_import}"
  role   = "${aws_iam_role.man_import.id}"
  policy = "${data.template_file.man_import.rendered}"
}

data "template_file" "man_import" {
  template = "${file("policy/policy-man-import.json")}"

  vars {
    S3_STASH_ARN = "${aws_s3_bucket.stash.arn}"
  }
}
