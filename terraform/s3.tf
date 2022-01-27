resource "aws_s3_bucket" "bucket" {
  bucket = var.domain
  acl    = "public-read"

  website {
    index_document = "infoWindow"
  }
}

resource "aws_s3_bucket" "www" {
  bucket = "www.${var.domain}"
  acl    = "private"
  policy = ""

  website {
    redirect_all_requests_to = "https://${var.domain}"
  }
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.bucket_policy.json
}

data "aws_iam_policy_document" "bucket_policy" {
  version = "2012-10-17"
  statement {
    sid    = "PublicReadGetObject"
    effect = "Allow"
    principals {
      identifiers = ["*"]
      type        = "*"
    }
    actions = [
      "s3:GetObject"
    ]
    resources = [
      aws_s3_bucket.bucket.arn,
      "${aws_s3_bucket.bucket.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_object" "html" {
  for_each     = fileset("../html/", "*.html")
  bucket       = aws_s3_bucket.bucket.id
  key          = trimsuffix(each.value, ".html")
  source       = "../html/${each.value}"
  etag         = filemd5("../html/${each.value}")
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "css" {
  for_each     = fileset("../static/", "*.css")
  bucket       = aws_s3_bucket.bucket.id
  key          = "static/${each.value}"
  source       = "../static/${each.value}"
  etag         = filemd5("../static/${each.value}")
  content_type = "text/css"
}

resource "aws_s3_bucket_object" "js" {
  for_each     = fileset("../static/", "*.js")
  bucket       = aws_s3_bucket.bucket.id
  key          = "static/${each.value}"
  source       = "../static/${each.value}"
  etag         = filemd5("../static/${each.value}")
  content_type = "text/javascript"
}

resource "aws_s3_bucket_object" "svg" {
  for_each     = fileset("../images/", "*.svg")
  bucket       = aws_s3_bucket.bucket.id
  key          = "images/${each.value}"
  source       = "../images/${each.value}"
  etag         = filemd5("../images/${each.value}")
  content_type = "image/svg+xml"
}

resource "aws_s3_bucket_object" "zip" {
  # note that this will not detect changes to this file.
  # either taint this or come up with a naming scheme
  # for the zip file
  for_each     = fileset("../downloads/", "*.zip")
  bucket       = aws_s3_bucket.bucket.id
  key          = "downloads/${each.value}"
  source       = "../downloads/${each.value}"
  content_type = "application/zip"
}