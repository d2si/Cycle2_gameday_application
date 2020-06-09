module "attendesdbmanagement_lambda" {
  source = "../module-lambda"

  lambda_name     = "attendesdbmanagement_lambda"
  role_name       = "attendesdbmanagement_lambda"
  policy_name     = "attendesdbmanagement_lambda"
  lambda_path     = "${path.module}/attendesdbmanagement_lambda"
  lambda_handler  = "index.handler"
  lambda_runtime  = "python3.8"
  policy_document = data.aws_iam_policy_document.attendesdbmanagement_lambda.json

  lambda_environment_variables = {
    Name        = "${var.application}${var.team_number}-attendesdbmanagement_lambda"
    Application = var.application
    Owner       = var.owner
  }
}
