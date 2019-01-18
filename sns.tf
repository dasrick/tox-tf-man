resource "aws_sns_topic" "address_import" {
  name = "${local.name_prefix}-address-import-topic"
}
