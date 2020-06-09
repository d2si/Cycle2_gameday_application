variable "use_caller_boundary" {
  description = "Indicate if we should attach the caller's boundary to lambda role"
  default     = false
  type        = bool
}

variable "lambda_name" {
  description = "Lambda name to create"
  type        = string
}

variable "role_name" {
  description = "Role name to attach to lambda"
  type        = string
}

variable "policy_name" {
  description = "Policy name to attach to lambda role"
  type        = string
}

variable "policy_document" {
  description = "Policy document to give rights lambda"
  type        = string
}

variable "lambda_path" {
  description = "Lambda source code path"
  type        = string
  default     = null
}

variable "lambda_zip" {
  description = "Lambda zip package"
  type        = string
  default     = null
}

variable "lambda_handler" {
  description = "Lambda handler name"
  type        = string
}

variable "lambda_runtime" {
  description = "Lambda source code runtime"
  type        = string
}

variable "lambda_timeout" {
  description = "Lambda timeout"
  default     = 3
  type        = number
}

variable "lambda_layers" {
  description = "Lambda layers"
  type        = list(string)
  default     = []
}

variable "lambda_memory" {
  description = "Lambda memory"
  default     = 128
  type        = number
}

variable "reserved_concurrent_executions" {
  description = "lambda reserved concurrency"
  default     = -1
  type        = number
}

variable "lambda_environment_variables" {
  description = "Lambda environement variable map"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to append to resources"
  default     = {}
  type        = map(string)
}

variable "tracing_config" {
  description = "AWS XRay tracing config"
  default     = "PassThrough"
  type        = string
}

variable "role_max_session_duration" {
  description = "Maximum session duration to set on the created role for lambda"
  default     = 3600
  type        = number
}
