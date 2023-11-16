/**
 * This file defines all variable inputs for the lambda-service module
 */

/*----------( Required Variables )----------*/

variable "project_key" {
  description = "The project key"
  type        = string
}

variable "deploy_packages_bucket" {
  description = "The S3 bucket used to store deploy packages"
  type        = string
}

variable "function_name" {
  description = "The Lambda function name"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the API"
  type        = string
}

variable "tls_certificate_arn" {
  description = "The ARN of the TLS certificate to use for the API"
  type        = string
}


/*----------( Optional - Configuration Variables )----------*/

variable "runtime" {
  description = "Lambda runtime to use"
  type        = string
  default     = "nodejs18.x"
}

variable "entrypoint" {
  description = "Lambda entrypoint"
  type        = string
  default     = "src/services/serverless.handler"
}

variable "timeout" {
  description = "timeout value for the lambda function in seconds"
  type        = number
  default     = 3
}

variable "memory_size" {
  description = "memory size for the lambda function in MB"
  type        = number
  default     = 128
}
variable "log_level" {
  description = "Log level"
  type        = string
  default     = "info"
}




