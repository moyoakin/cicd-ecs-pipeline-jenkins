resource "aws_ecr_repository" "frontend_repo" {
  name                 = "techpathway-frontend"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "techpathway-frontend"
  }
}

resource "aws_ecr_repository" "backend_repo" {
  name                 = "techpathway-backend"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "techpathway-backend"
  }
}