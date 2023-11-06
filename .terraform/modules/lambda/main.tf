module "iam" {
  source = "../iam"
  project_name = var.project_name
  region = var.aws_region
  tags = var.tags
}

module "vpc" {
  source = "../vpc"
  project_name = var.project_name
  region = var.aws_region
  tags = var.tags
}

resource "aws_lambda_function" "lambda" {
  function_name    = "${var.project_name}-lambda-${var.app_env}"
  filename         = "lambda_function_payload.zip"
  source_code_hash = filebase64sha256("lambda_function_payload.zip")
  handler          = "index.handler"
  role             = module.iam.iam_lambda_role
  runtime          = "nodejs14.x"
  vpc_config {
    subnet_ids = [module.vpc.subnet_id]
    security_group_ids = [module.vpc.security_group_id]
  }
}



# resource "aws_lambda_function" "lambda_function" {
#   function_name = var.name
#   role          = var.iam_for_lambda
#   image_uri     = format("%s:latest", "${var.image_uri}")
#   package_type  = "Image"
#   memory_size   = var.lambda_memory
#   timeout       = var.lambda_timeout

#   lifecycle {
#     ignore_changes = [
#       environment,
#       image_uri
#     ]
#   }
# }

# resource "aws_security_group" "this" {
#   description = var.name
#   egress = [
#     {
#       cidr_blocks = [
#         "0.0.0.0/0",
#       ]
#       description      = ""
#       from_port        = 0
#       ipv6_cidr_blocks = []
#       prefix_list_ids  = []
#       protocol         = "-1"
#       security_groups  = []
#       self             = false
#       to_port          = 0
#     },
#   ]

#   ingress = [
#     {
#       description      = "HTTPS"
#       from_port        = 443
#       to_port          = 443
#       protocol         = "tcp"
#       ipv6_cidr_blocks = []
#       prefix_list_ids  = []
#       security_groups  = []
#       self             = false
#       cidr_blocks      = ["0.0.0.0/0"]
#     }

#   ]

#   name   = var.name
#   tags   = var.tags
#   vpc_id = var.vpc_id

#   timeouts {}
# }

# resource "aws_lambda_permission" "lambda_permission" {
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.lambda_function.function_name
#   principal     = "apigateway.amazonaws.com"

#   # The /*/*/* part allows invocation from any stage, method and resource path
#   # within API Gateway REST API.
#   # source_arn = "${var.source_arn}/*/*/*"
# }
