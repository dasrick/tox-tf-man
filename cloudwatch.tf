resource "aws_cloudwatch_log_group" "lambda_importer" {
  depends_on        = ["aws_lambda_function.importer"]
  name              = "/aws/lambda/${aws_lambda_function.importer.function_name}"
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "lambda_transformer" {
  depends_on        = ["aws_lambda_function.transformer"]
  name              = "/aws/lambda/${aws_lambda_function.transformer.function_name}"
  retention_in_days = 90
}
