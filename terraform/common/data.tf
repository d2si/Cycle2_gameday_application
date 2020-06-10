
data "aws_iam_policy_document" "attendesdbmanagement_lambda" {
  statement {
    sid = "AllowLogging"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "lambda:*",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    sid = "AllowAccessToWallabyDatabase"

    actions = [
      "dynamodb:GetItem",
      "dynamodb:BatchGetItem",
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem",
      "dynamodb:BatchWriteItem",
    ]

    resources = [
      aws_dynamodb_table.ddb.arn,
    ]
  }
}
