locals {
  role_name_man_service = "${local.name_prefix}-man-service"
}

// ROLES ===============================================================================================================
resource "aws_iam_role" "man_service" {
  name               = "${local.role_name_man_service}"
  assume_role_policy = "${file("policy/assume-role-policy-lambda.json")}"

  tags               = "${merge(local.common_tags, map(
    "Name", local.role_name_man_service
  ))}"
}

// POLICIES ============================================================================================================
resource "aws_iam_role_policy" "man_service" {
  name   = "${local.role_name_man_service}"
  role   = "${aws_iam_role.man_service.id}"
  policy = "${data.template_file.man_service.rendered}"
}

// POLICY TEMPLATES ====================================================================================================
data "template_file" "man_service" {
  template = "${file("policy/policy-man-service.json")}"
  //  vars {
  //    dynamodb-table-esearch-importer-rule-one-rs-arn = "${module.esearch-billpay-rule-one-rs.arn}"
  //    dynamodb-table-esearch-importer-rule-two-rs-arn = "${module.esearch-billpay-rule-two-rs.arn}"
  //  }
}
