output "ecr_repository" {
  value = aws_ecr_repository.onb-student-import-lambda.repository_url
}
