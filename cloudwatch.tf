// lambda unzip --------------------------------------------------------------------------------------------------------
resource "aws_cloudwatch_log_group" "lambda_unzip" {
  depends_on = ["aws_lambda_function.man_unzip"]
  name       = "/aws/lambda/${aws_lambda_function.man_unzip.function_name}"
}
// lambda dummyone --------------------------------------------------------------------------------------------------------
resource "aws_cloudwatch_log_group" "lambda_dummyone" {
  depends_on = ["aws_lambda_function.man_dummyone"]
  name       = "/aws/lambda/${aws_lambda_function.man_dummyone.function_name}"
}
// lambda dummytwo --------------------------------------------------------------------------------------------------------
resource "aws_cloudwatch_log_group" "lambda_dummytwo" {
  depends_on = ["aws_lambda_function.man_dummytwo"]
  name       = "/aws/lambda/${aws_lambda_function.man_dummytwo.function_name}"
}
