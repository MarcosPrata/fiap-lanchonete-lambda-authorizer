module "lambda" {
  source = "./modules/lambda"
  app_env = var.app_env
  aws_region = var.aws_region
  project_name = var.project_name
  tags = local.tags
}


# ### ECR
# resource "aws_ecr_repository" "onb-student-import-lambda" {
#   name                 = "${var.project_name}-${var.app_env}"
#   image_tag_mutability = "MUTABLE"
#   image_scanning_configuration {
#     scan_on_push = false
#   }
#   tags = local.tags
# }

# resource "aws_ecr_lifecycle_policy" "onb-student-import-lambda-policy" {
#   repository = aws_ecr_repository.onb-student-import-lambda.name
#   policy     = <<EOF
# {
#     "rules": [
#         {
#             "rulePriority": 1,
#             "description": "Keep last 15 images",
#             "selection": {
#                 "tagStatus": "any",
#                 "countType": "imageCountMoreThan",
#                 "countNumber": 15
#             },
#             "action": {
#                 "type": "expire"
#             }
#         }
#     ]
# }
# EOF
# }


# ### LAMBDA
# module "lambda" {
#   source         = "./module/lambda"
#   image_uri      = aws_ecr_repository.onb-student-import-lambda.repository_url
#   name           = "${var.project}-${var.env}"
#   iam_for_lambda = aws_iam_role.lambda_iam.arn
#   lambda_timeout = 30
#   lambda_memory  = 512
#   vpc_id         = data.aws_vpc.selected.id
#   subnet_ids     = [sort(data.aws_subnet_ids.private.ids)[0]]
#   vpc_name       = var.vpc_name

#   env = local.environment

#   tags = local.tags

# }

# ## IAM GITHUB
# resource "aws_iam_user" "gh_user_pipeline" {
#   name = "${var.project_name}-${var.app_env}"
#   path = "/"
#   tags = local.tags

#   lifecycle {
#     prevent_destroy = true
#   }
# }

# resource "aws_iam_access_key" "gh_access_key_pipeline" {
#   user = aws_iam_user.gh_user_pipeline.name

#   lifecycle {
#     prevent_destroy = true
#   }
# }

# resource "aws_iam_role" "lambda_iam" {
#   name = "${var.project_name}-${var.app_env}"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           Service = ["lambda.amazonaws.com"]
#         }
#       },
#     ]
#   })
# }


# ### POLICY
# resource "aws_iam_user_policy" "gh_user_pipeline" {
#   name = "${var.project}-${var.env}-policy"
#   user = aws_iam_user.gh_user_pipeline.name
#   lifecycle {
#     prevent_destroy = true
#   }
#   policy = jsonencode({
#     "Version" : "2012-10-17",
#     "Statement" : [
#       {
#         "Sid" : "VisualEditor0",
#         "Effect" : "Allow",
#         "Action" : [
#           "ecr:GetRegistryPolicy",
#           "ecr:CreateRepository",
#           "ecr:DescribeRegistry",
#           "ecr:DescribePullThroughCacheRules",
#           "ecr:GetAuthorizationToken",
#           "ecr:PutRegistryScanningConfiguration",
#           "ecr:CreatePullThroughCacheRule",
#           "ecr:DeletePullThroughCacheRule",
#           "ecr:PutRegistryPolicy",
#           "ecr:GetRegistryScanningConfiguration",
#           "ecr:BatchImportUpstreamImage",
#           "ecr:DeleteRegistryPolicy",
#           "ecr:PutReplicationConfiguration"
#         ],
#         "Resource" : "*"
#       },
#       {
#         "Sid" : "VisualEditor1",
#         "Effect" : "Allow",
#         "Action" : "ecr:*",
#         "Resource" : "${aws_ecr_repository.onb-student-import-lambda.arn}"
#       },
#       {
#         "Action" : "lambda:UpdateFunctionCode",
#         "Effect" : "Allow",
#         "Resource" : "${module.lambda.lambda_arn}"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy" "revoke_keys_role_policy" {
# 	  name = "${var.project}-${var.env}"
# 	  role = aws_iam_role.lambda_iam.id
# 	  policy = jsonencode({
# 	    "Version" : "2012-10-17",
# 	    "Statement" : [
# 	      {
# 		"Action" : [
# 		  "ecr:Get*",
# 		  "ecr:List*",
# 		  "ecr:Describe*",
# 		  "ecr:BatchGetImage",
# 		  "ecr:BatchCheckLayerAvailability"
# 		],
# 		"Effect" : "Allow",
# 		"Resource" : "${aws_ecr_repository.onb-student-import-lambda.arn}"
# 	      },
# 	      {
# 		"Action" : [
# 		  "logs:CreateLogStream",
# 		  "logs:PutLogEvents"
# 		],
# 		"Effect" : "Allow",
# 		"Resource" : "arn:aws:logs:*:*:*"
# 	      },
# 	      {
# 		"Effect" : "Allow",
# 		"Action" : [
# 		  "ec2:DescribeNetworkInterfaces",
# 		  "ec2:CreateNetworkInterface",
# 		  "ec2:DeleteNetworkInterface",
# 		  "ec2:DescribeInstances",
# 		  "ec2:AttachNetworkInterface"
# 		],
# 		"Resource" : "*"
# 	      },
# 		  {
# 		"Effect" : "Allow",
# 		"Action": [
#             "sqs:ListQueues",
#             "sqs:GetQueueUrl",
#             "sqs:ListDeadLetterSourceQueues",
#             "sqs:ReceiveMessage",
#             "sqs:SendMessage",
#             "sqs:GetQueueAttributes",
#             "sqs:ListQueueTags",
#             "sqs:CreateQueue"
#             ],
#         "Resource": "${data.aws_sqs_queue.student.arn}"
# 	  	  },	
# 	      {
# 		    "Sid": "VisualEditor0",
# 		    "Effect": "Allow",
# 		    "Action": [
# 		        "eks:ListNodegroups",
# 		        "eks:DescribeFargateProfile",
# 		        "eks:ListTagsForResource",
# 		        "eks:ListAddons",
# 		        "eks:DescribeAddon",
# 		        "eks:ListFargateProfiles",
# 		        "eks:DescribeNodegroup",
# 		        "eks:DescribeIdentityProviderConfig",
# 		        "eks:ListUpdates",
# 		        "eks:DescribeUpdate",
# 		        "eks:AccessKubernetesApi",
# 		        "eks:DescribeCluster",
# 		        "eks:ListIdentityProviderConfigs"
# 		    ],
# 		    "Resource": "${data.aws_eks_cluster.componentes.arn}"
# 		},
# 		{
# 		    "Sid": "VisualEditor1",
# 		    "Effect": "Allow",
# 		    "Action": [
# 		        "eks:DescribeAddonConfiguration",
# 		        "eks:ListClusters",
# 		        "eks:DescribeAddonVersions"
# 		    ],
# 		    "Resource": "${data.aws_eks_cluster.componentes.arn}"
# 		}
# 	    ]
# 	  })
# 	}
