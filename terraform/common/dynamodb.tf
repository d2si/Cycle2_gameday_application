resource "aws_dynamodb_table" "ddb" {
  name           = "ddb_table_${var.application}${var.team_number}"
  read_capacity  = var.ddb_read_cap
  write_capacity = var.ddb_write_cap
  hash_key       = "lastname"
  range_key      = "firstname"

  attribute {
    name = "lastname"
    type = "S"
  }

  attribute {
    name = "firstname"
    type = "S"
  }
}

resource "aws_iam_role_policy" "ddb_admin" {
  name = "ddb_admin_role_policy_${var.application}${var.team_number}"
  role = aws_iam_role.web.id

  policy = <<EOF
{
      "Statement": [
          {
              "Sid":"DynamodbAllow",
              "Effect":"Allow",
              "Action":[
                  "dynamodb:*"
              ],
              "Resource": "${aws_dynamodb_table.ddb.arn}"
          },
          {
              "Sid":"LogAllow",
              "Effect": "Allow",
              "Action": [
                  "logs:CreateLogStream",
                  "logs:CreateLogGroup",
                  "logs:PutLogEvents"
              ],
              "Resource": "*"
          }
      ],
      "Version": "2012-10-17"
  }
EOF

}
