data "template_file" "user_data" {
  template = file("front_userdata.tpl")

  vars = {
    vpc              = "${var.application}${var.team_number}"
    environment      = var.environment
    version          = var.version1
    ddbtable         = aws_dynamodb_table.ddb.id
    aws_region       = var.aws_region
    team_name        = "${var.application}-${var.team_number}"
    aws_sdk_version  = var.aws_sdk_version
    api_url          = aws_api_gateway_deployment.deployment.invoke_url
    }
}
