locals {
  docker_dir = "../send_contact_email"
}
resource "aws_ecr_repository" "send_contact_email" {
  name = "send-contact-email"
}

resource "null_resource" "ecr_image_build" {
  triggers = {
    docker_file = filemd5("${local.docker_dir}/Dockerfile")
    python_file = filemd5("${local.docker_dir}/send_contact_email.py")
  }

  provisioner "local-exec" {
    command = <<EOF
      aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com
      cd ${local.docker_dir}
      docker build -t ${aws_ecr_repository.send_contact_email.repository_url}:latest .
      docker push ${aws_ecr_repository.send_contact_email.repository_url}:latest
    EOF
  }
}

data "aws_ecr_image" "ecr_image" {
  depends_on      = [null_resource.ecr_image_build]
  repository_name = aws_ecr_repository.send_contact_email.name
  image_tag       = "latest"
}