locals {
  dynamodb_source = "${local.name_prefix}-source"
}

resource "aws_dynamodb_table" "man_source" {
  name         = "${local.dynamodb_source}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "HaID"

  attribute {
    name = "HaID"
    type = "S"
  }

  tags = "${merge(local.common_tags, map(
    "Name", local.dynamodb_source
  ))}"
}
