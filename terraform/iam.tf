resource "aws_iam_role" "send_contact_email_lambda" {
  name = var.lambda_function_name
  path = "/service_role/"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "send_contact_email_lambda" {
  name        = "send_contact_email_lambda"
  description = "Policy for the send contact email execution role"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # Not sure if this permission is necessary, since I've created the log group already
      {
        Effect : "Allow",
        Action : "logs:CreateLogGroup",
        Resource : "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:*",
      },
      {
        Effect : "Allow",
        Action : [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ],
        Resource : [
          "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.lambda_function_name}:*",
        ]
      },
      {
        Effect : "Allow",
        Action : [
          "ses:SendEmail",
          "ses:SendRawEmail"
        ],
        Resource : "*",
        Condition: {
          "ForAllValues:StringLike":{
            "ses:Recipients":[
              var.email_address
            ]
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "send_contact_email_lambda" {
  role       = aws_iam_role.send_contact_email_lambda.name
  policy_arn = aws_iam_policy.send_contact_email_lambda.arn
}