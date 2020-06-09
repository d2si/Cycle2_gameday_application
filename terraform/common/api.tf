resource "aws_api_gateway_rest_api" "apirest" {
  name = "attendes-dbmanagement-api"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}


resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.apirest.id
  resource_id   = aws_api_gateway_rest_api.apirest.root_resource_id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.apirest.id
  resource_id             = aws_api_gateway_rest_api.apirest.root_resource_id
  http_method             = aws_api_gateway_method.method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = module.attendesdbmanagement_lambda.lambda_invoke_arn
}

resource "aws_api_gateway_deployment" "deployment" {
   depends_on = [
     aws_api_gateway_integration.integration,
   ]

   rest_api_id = aws_api_gateway_rest_api.apirest.id
   stage_name  = "prod"
 }
