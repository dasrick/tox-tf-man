resource "aws_lambda_permission" "s3_stash_lambda_unzip" {
  statement_id  = "AllowExecutionFromS3BucketToLambdaUnzip"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.man_unzip.function_name}"
  principal     = "s3.amazonaws.com"
  source_arn    = "${aws_s3_bucket.stash.arn}"
}
resource "aws_lambda_permission" "s3_stash_lambda_import" {
  statement_id  = "AllowExecutionFromS3BucketToLambdaImport"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.man_import.function_name}"
  principal     = "s3.amazonaws.com"
  source_arn    = "${aws_s3_bucket.stash.arn}"
}
