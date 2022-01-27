resource "aws_lambda_function" "send_contact_email" {
  depends_on       = [null_resource.ecr_image_build]
  function_name    = var.lambda_function_name
  role             = aws_iam_role.send_contact_email_lambda.arn
  package_type     = "Image"
  image_uri        = "${aws_ecr_repository.send_contact_email.repository_url}:latest"
  source_code_hash = trimprefix(data.aws_ecr_image.ecr_image.id, "sha256:")
  environment {
    variables = {
      EMAIL_ADDRESS = var.email_address
    }
  }
}