resource "aws_cloudwatch_log_group" "send_contact_email" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 150
}