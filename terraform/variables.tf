variable "access_key" {
  #Add AWS access key here
  default = ""
}

variable "secret_key" {
  #Add AWS secret key here
  default = ""
}

# Default region
variable "region" {
  default = "us-east-1"
}

# region
variable "another_region" {
  default = "eu-west-2"
}

# Lambda role
variable "lambda_role" {
  description = "IAM role ARN attached to the Lambda Function. This governs both who / what can invoke your Lambda Function, as well as what resources our Lambda Function has access to. See Lambda Permission Model for more details."
  type        = string
  default     = ""
}