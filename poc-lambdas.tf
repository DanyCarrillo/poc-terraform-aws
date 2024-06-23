
locals {
   poc_lambda_config = {
    timeout        = 60
    memory_size    = 1024
    lambda_runtime = "nodejs20.x"
  }

  poc_lambda_template_base = {
    name           = "poc-template-base"
    lambda_handler = "build/src/handler.handler"
  }
}

data "aws_iam_policy_document" "poc_data_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "poc_iam_for_lambda" {
  name               = "poc_iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.poc_data_assume_role.json
}


resource "aws_lambda_function" "poc_lambda_template_base" {
  
  description   = format("Lambda function for %s", local.poc_lambda_template_base.name)
  filename      = "./dummies/lambdas/lambda_function_payload.zip"
  function_name = local.poc_lambda_template_base.name
  role          = aws_iam_role.poc_iam_for_lambda.arn
  handler       = local.poc_lambda_template_base.lambda_handler
  
  runtime = local.poc_lambda_config.lambda_runtime
  memory_size = local.poc_lambda_config.memory_size
  timeout = local.poc_lambda_config.timeout

}
