resource "aws_lambda_permission" "s3_stash_lambda_importer" {
  statement_id  = "AllowExecutionFromS3BucketToLambdaImporter"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.importer.function_name}"
  principal     = "s3.amazonaws.com"
  source_arn    = "${aws_s3_bucket.stash.arn}"
  depends_on    = ["aws_lambda_function.importer"]
}

resource "aws_lambda_permission" "sns_lambda_transformer" {
  statement_id  = "AllowExecutionFromSNSTopicToLambdaTransformer"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.transformer.function_name}"
  principal     = "sns.amazonaws.com"
  source_arn    = "${aws_sns_topic.address_import.arn}"
  depends_on    = ["aws_lambda_function.transformer"]
}
