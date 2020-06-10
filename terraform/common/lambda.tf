data "aws_caller_identity" "current" {}
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
    Table       = "ddb_table_${var.application}${var.team_number}"
  }
}
resource "aws_lambda_permission" "attendesdbmanagement_lambda_allow_api_gateway" {

  depends_on = [
    module.attendesdbmanagement_lambda,
    aws_api_gateway_rest_api.apirest,
    aws_api_gateway_method.method
  ]

  function_name = module.attendesdbmanagement_lambda.lambda_name
  statement_id = "AllowExecutionFromApiGateway_users_delete"
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.apirest.id}/${aws_api_gateway_stage.prod.stage_name}/${aws_api_gateway_method.method.http_method}/"
}
