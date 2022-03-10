variable "name" {
  type        = string
  description = "Used to prefix created resource names"
}

variable "tags" {
  type        = map(string)
  description = "A map of AWS Tags to attach to each resource created"
  default     = {}
}

variable "bucket_name" {
  type        = string
  description = "Bucket name for the S3 bucket to store state files"
  default     = ""
}

variable "dynamodb_table_name" {
  type        = string
  description = "DynamoDB table name for locking state files"
  default     = ""
}
