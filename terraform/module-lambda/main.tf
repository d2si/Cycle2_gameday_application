data "aws_caller_identity" "current" {}

data "aws_iam_user" "current" {
  user_name = "${element(split("/", data.aws_caller_identity.current.arn), length(split("/", data.aws_caller_identity.current.arn)) - 1)}"
}

locals {
  permissions_boundary = "${data.aws_iam_user.current.permissions_boundary}"
}

resource "aws_iam_role" "lambda" {
  name                 = "${var.role_name}"
  permissions_boundary = "${var.use_caller_boundary ? local.permissions_boundary : ""}"
  assume_role_policy   = "${file("${path.module}/lambda_assume_role_policy.json")}"
  tags                 = "${merge(map("Name", format("%s", var.role_name)), var.tags)}"
}

resource "aws_iam_policy" "lambda" {
  name   = "${var.policy_name}"
  policy = "${var.policy_document}"
}

resource "aws_iam_role_policy_attachment" "lambda" {
  role       = "${aws_iam_role.lambda.name}"
  policy_arn = "${aws_iam_policy.lambda.arn}"
}

data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "${var.lambda_path}"
  output_path = "${var.lambda_name}.zip"
  count       = "${var.lambda_path != "" ? 1 : 0}"
}

resource "aws_lambda_function" "lambda_packaged" {
  filename                       = "${var.lambda_zip}"
  function_name                  = "${var.lambda_name}"
  timeout                        = "${var.lambda_timeout}"
  role                           = "${aws_iam_role.lambda.arn}"
  handler                        = "${var.lambda_handler}"
  source_code_hash               = "${filebase64sha256(var.lambda_zip)}"
  runtime                        = "${var.lambda_runtime}"
  tags                           = "${merge(map("Name", format("%s", var.lambda_name)), var.tags)}"
  layers                         = ["${var.lambda_layers}"]
  memory_size                    = "${var.lambda_memory}"
  reserved_concurrent_executions = "${var.reserved_concurrent_executions}"

  environment {
    variables = "${var.lambda_environment_variables}"
  }

  count = "${var.lambda_zip != "" ? 1 : 0}"
}

resource "aws_lambda_function" "lambda_source" {
  filename                       = "${data.archive_file.lambda.0.output_path}"
  function_name                  = "${var.lambda_name}"
  timeout                        = "${var.lambda_timeout}"
  role                           = "${aws_iam_role.lambda.arn}"
  handler                        = "${var.lambda_handler}"
  source_code_hash               = "${data.archive_file.lambda.0.output_base64sha256}"
  runtime                        = "${var.lambda_runtime}"
  tags                           = "${merge(map("Name", format("%s", var.lambda_name)), var.tags)}"
  layers                         = ["${var.lambda_layers}"]
  memory_size                    = "${var.lambda_memory}"
  reserved_concurrent_executions = "${var.reserved_concurrent_executions}"

  environment {
    variables = "${var.lambda_environment_variables}"
  }

  count = "${var.lambda_path != "" ? 1 : 0}"
}
