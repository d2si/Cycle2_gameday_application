output "lambda_name" {
  value = "${var.lambda_name}"
}

output "lambda_arn" {
  value = "${var.lambda_path != "" ? element(concat(aws_lambda_function.lambda_source.*.arn, list("")), 0) : element(concat(aws_lambda_function.lambda_packaged.*.arn, list("")), 0)}"
}

output "role_arn" {
  value = "${aws_iam_role.lambda.arn}"
}
