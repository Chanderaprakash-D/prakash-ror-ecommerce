resource "aws_ecr_repository" "app" {
  name = var.namespace

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.namespace}-ecr"
  }
}