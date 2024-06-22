variable "region" {
  description = "The AWS region to deploy to"
  default     = "eu-north-1"
}

variable "AWS_ACCESS_KEY_ID" {
  description = "AWS access key"
  type        = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS secret key"
  type        = string
}