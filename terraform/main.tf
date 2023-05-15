###########################################################
# AWS init for region 1
###########################################################
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region

  # Make it faster by skipping something
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}

###########################################################
# AWS init for region 2
###########################################################
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "eu-west-2"
  alias      = "eu-west-2"

  # Make it faster by skipping something
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}


module "lambda_function" {
  source        = "terraform-aws-modules/lambda/aws"
  count         = 5
  function_name = "proxy_${count.index}"
  handler       = "main"
  runtime       = "go1.x"
  source_path = [
    "../main",
  ]
  create_role                = false
  lambda_role                = aws_iam_role.lambda.arn
}

###########################################################
# Using different region and IAM role name (policy prefix)
###########################################################
module "lambda_function_another_region" {
  ###########################################################
  # Using different region and IAM role name (policy prefix)
  ###########################################################
  providers = {
    aws = aws.eu-west-2
  }

  source        = "terraform-aws-modules/lambda/aws"
  count         = 5
  function_name = "proxy_${count.index}"
  handler       = "main"
  runtime       = "go1.x"
  source_path = [
    "../main",
  ]
  create_role                = false
  create_lambda_function_url = true
  lambda_role                = aws_iam_role.lambda.arn
}


data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda" {
  name               = "lambda-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}


