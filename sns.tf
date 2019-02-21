resource "aws_sns_topic" "address_import" {
  name = "${local.name_prefix}-address-import-topic"
}

resource "aws_sns_topic_subscription" "address_import_target" {
  depends_on = [
    "aws_sns_topic.address_import",
    "aws_lambda_function.transformer",
  ]

  topic_arn = "${aws_sns_topic.address_import.arn}"
  protocol  = "lambda"
  endpoint  = "${aws_lambda_function.transformer.arn}"
}
