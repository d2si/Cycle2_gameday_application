variable "use_caller_boundary" {
  description = "Indicate if we should attach the caller's boundary to lambda role"
  default     = false
}

variable "lambda_name" {
  description = "Lambda name to create"
}

variable "role_name" {
  description = "Role name to attach to lambda"
}

variable "policy_name" {
  description = "Policy name to attach to lambda role"
}

variable "policy_document" {
  description = "Policy document to give rights lambda"
}

variable "lambda_path" {
  description = "Lambda source code path"
  default     = ""
}

variable "lambda_zip" {
  description = "Lambda zip package"
  default     = ""
}

variable "lambda_handler" {
  description = "Lambda handler name"
}

variable "lambda_runtime" {
  description = "Lambda source code runtime"
}

variable "lambda_timeout" {
  description = "Lambda timeout"
  default     = "3"
}

variable "lambda_layers" {
  description = "Lambda layers"
  type        = "list"
  default     = []
}

variable "lambda_memory" {
  description = "Lambda memory"
  default     = "128"
}

variable "reserved_concurrent_executions" {
  description = "lambda reserved concurrency"
  default     = "-1"
}

variable "lambda_environment_variables" {
  description = "Lambda environement variable map"
  type        = "map"
  default     = {}
}

variable "tags" {
  description = "Tags to append to resources"
  default     = {}
}
