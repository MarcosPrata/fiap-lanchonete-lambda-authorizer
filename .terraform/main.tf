module "lambda" {
  source                   = "./modules/lambda"
  app_env                  = var.app_env
  aws_region               = var.aws_region
  project_name             = var.project_name
  lambda_dir               = var.lambda_dir
  lambda_dir_exclude_files = var.lambda_dir_exclude_files
  tags                     = local.tags
}
