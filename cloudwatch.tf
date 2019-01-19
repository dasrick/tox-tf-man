// lambda importer -------------------------------------------------------------------------------------------------------
resource "aws_cloudwatch_log_group" "lambda_importer" {
  depends_on        = ["aws_lambda_function.man_importer"]
  name              = "/aws/lambda/${aws_lambda_function.man_importer.function_name}"
  retention_in_days = 90
}

// lambda import -------------------------------------------------------------------------------------------------------
resource "aws_cloudwatch_log_group" "lambda_transformer" {
  depends_on        = ["aws_lambda_function.man_transformer"]
  name              = "/aws/lambda/${aws_lambda_function.man_transformer.function_name}"
  retention_in_days = 90
}
