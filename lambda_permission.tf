resource "aws_lambda_permission" "s3_stash_lambda_importer" {
  statement_id  = "AllowExecutionFromS3BucketToLambdaImporter"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.man_importer.function_name}"
  principal     = "s3.amazonaws.com"
  source_arn    = "${aws_s3_bucket.stash.arn}"
  depends_on    = ["aws_lambda_function.man_importer"]
}
