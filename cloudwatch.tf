// lambda unzip --------------------------------------------------------------------------------------------------------
resource "aws_cloudwatch_log_group" "lambda_unzip" {
  depends_on        = ["aws_lambda_function.man_unzip"]
  name              = "/aws/lambda/${aws_lambda_function.man_unzip.function_name}"
  retention_in_days = 90
}

// lambda import -------------------------------------------------------------------------------------------------------
resource "aws_cloudwatch_log_group" "lambda_import" {
  depends_on        = ["aws_lambda_function.man_import"]
  name              = "/aws/lambda/${aws_lambda_function.man_import.function_name}"
  retention_in_days = 90
}
