// sample --------------------------------------------------------------------------------------------------------------
resource "aws_cloudwatch_log_group" "sample" {
  name              = "sample"
  retention_in_days = 14
}
