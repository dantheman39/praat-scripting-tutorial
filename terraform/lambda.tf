resource "aws_lambda_function" "send_contact_email" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.send_contact_email_lambda.arn
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.send_contact_email.repository_url}:latest"
}