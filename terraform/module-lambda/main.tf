resource "aws_iam_role" "lambda" {
  name                 = var.role_name
  assume_role_policy   = file("${path.module}/lambda_assume_role_policy.json")
  max_session_duration = var.role_max_session_duration
  tags = merge(
    {
      "Name" = format("%s", var.role_name)
    },
    var.tags,
  )
}

resource "aws_iam_policy" "lambda" {
  name   = var.policy_name
  policy = var.policy_document
}

resource "aws_iam_role_policy_attachment" "lambda" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda.arn
}

data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = var.lambda_path
  output_path = "${var.lambda_name}.zip"
  count       = var.lambda_path != null ? 1 : 0
}

resource "aws_lambda_function" "main" {
  filename         = var.lambda_path != null ? data.archive_file.lambda[0].output_path : var.lambda_zip
  function_name    = var.lambda_name
  timeout          = var.lambda_timeout
  role             = aws_iam_role.lambda.arn
  handler          = var.lambda_handler
  source_code_hash = var.lambda_path != null ? data.archive_file.lambda[0].output_base64sha256 : filebase64sha256(var.lambda_zip)
  runtime          = var.lambda_runtime

  tags = merge(
    {
      "Name" = format("%s", var.lambda_name)
    },
    var.tags,
  )

  layers                         = var.lambda_layers
  memory_size                    = var.lambda_memory
  reserved_concurrent_executions = var.reserved_concurrent_executions

  tracing_config {
    mode = var.tracing_config
  }

  environment {
    variables = var.lambda_environment_variables
  }
}
