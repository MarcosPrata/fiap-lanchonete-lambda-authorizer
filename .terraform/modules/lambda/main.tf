module "iam" {
  source       = "../iam"
  project_name = var.project_name
  region       = var.aws_region
  tags         = var.tags
}

data "archive_file" "lambda_package" {
  type        = "zip"
  output_path = "lambda.zip"
  source_dir  = var.lambda_dir
  excludes    = var.lambda_dir_exclude_files
}

resource "aws_lambda_function" "lambda" {
  function_name    = "${var.project_name}-lambda-${var.app_env}"
  filename         = "lambda.zip"
  source_code_hash = data.archive_file.lambda_package.output_base64sha256
  handler          = "index.handler"
  role             = module.iam.iam_lambda_role
  runtime          = "nodejs14.x"
}
