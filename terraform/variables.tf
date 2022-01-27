variable "domain" {
  type    = string
  default = "praatscriptingtutorial.com"
}
variable "region" {
  type    = string
  default = "us-east-1"
}

variable "lambda_function_name" {
  type    = string
  default = "send_contact_email"
}

variable "email_address" {
  type    = string
}

variable "cloudflare_api_token" {
  type    = string
}