output "lambda_name" {
  value = var.lambda_name
}

output "lambda_arn" {
  value = aws_lambda_function.main.arn
}

output "role_arn" {
  value = aws_iam_role.lambda.arn
}

output "lambda_invoke_arn" {
  value = aws_lambda_function.main.invoke_arn
}
