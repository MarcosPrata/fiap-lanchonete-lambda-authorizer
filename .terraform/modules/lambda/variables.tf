variable "app_env" {}

variable "aws_region" {}

variable "project_name" {}

variable "tags" {}

variable "lambda_dir" {
  type = string
}

variable "lambda_dir_exclude_files" {
  type = list(string)
}
