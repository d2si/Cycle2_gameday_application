# AWS Certificate Terraform Module

[![D2SI](Resources/d2si-logo.png)](https://www.d2si.io/)

This terraform module provides a lambda resource:

* IAM role for lambda (with boundary if required)
* IAM policy attached to role
* Lambda function
* Directory archive to deploy lambda

## Inputs

| Name                           | Description                                                       |  Type  |    Default    |        Required        |
|--------------------------------|-------------------------------------------------------------------|:------:|:-------------:|:----------------------:|
| lambda_name                    | Lambda name to create                                             | string |      ``       |          yes           |
| role_name                      | Role name to attach to lambda                                     | string |      ``       |          yes           |
| policy_name                    | Policy name to attach to lambda role                              | string |      ``       |          yes           |
| policy_document                | Policy document to give rights lambda                             | string |      ``       |          yes           |
| lambda_path                    | Lambda source code path                                           | string |      ``       | only if no lambda_zip  |
| lambda_zip                     | Lambda zip package path                                           | string |      ``       | only if no lambda_path |
| lambda_handler                 | Lambda handler name                                               | string |      ``       |          yes           |
| lambda_runtime                 | Lambda source code runtime                                        | string |      ``       |          yes           |
| lambda_environment_variables   | Lambda environement variable map                                  | string |      ``       |          yes           |
| lambda_timeout                 | Lambda timeout                                                    | string |      `3`      |           no           |
| lambda_memory                  | Lambda memory                                                     | string |     `128`     |           no           |
| lambda_layers                  | Lambda layers ARN to attach                                       |  list  |     `[]`      |           no           |
| reserved_concurrent_executions | Lambda memory                                                     | string |     `-1`      |           no           |
| use_caller_boundary            | Indicate if we should attach the caller's boundary to lambda role | string |    `false`    |           no           |
| tags                           | Tags to append to resources                                       | string |     `{}`      |           no           |
| tracing_config                 | AWS XRay tracing config                                           | string | `PassThrough` |           no           |
| role_max_session_duration      | Maximum session duration to set on the created role for lambda    | string |    `3600`     |           no           |

## Outputs

| Name        | Description              |
|-------------|--------------------------|
| lambda_name | The created lambda name. |
| lambda_arn  | The created lambda ARN.  |
| role_arn    | The create role ARN.     |

## Usages

```hcl

module "lambda" {

  use_caller_boundary = true
  lambda_name         = "MadByD2SI"
  role_name           = "MadByD2SI-role"
  policy_name         = "MadByD2SI-policy"
  policy_document     = "${data.aws_iam_policy_document.icelab_lambda_policy.json}"
  lambda_zip          = "lambda/MadByD2SI.zip"
  lambda_handler      = "MadByD2SI.lambda_handler"
  lambda_runtime      = "python3.6"

  lambda_environment_variables = {
    ENV_NAME = "production"
  }
}

```

### Execution

Be sure that Terraform is installed by running this command line:

```shell
> terraform
usage: terraform |--version] |--help] <command> |args]
(...)
```

If Terraform is not installed, follow the [instructions here](https://www.terraform.io/intro/getting-started/install.html) to install it
or use the installation script in the scripts folder

In order for Terraform to be able to make changes in your AWS account, you will need to set the AWS credentials for the user you created earlier as environment variables:

```shell
export AWS_ACCESS_KEY_ID=(your access key id)
export AWS_SECRET_ACCESS_KEY=(your secret access key)
```

Run the "terraform apply" command to create the architecture:

```shell
terraform init
terraform apply
```
