terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = ">= 3.0.0"
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  # these locals are only used in this block for readability
  account_id          = data.aws_caller_identity.current.account_id
  region              = data.aws_region.current.name
  default_bucket_name = "terraform-state-storage-${local.account_id}"
  default_table_name  = "terraform-state-lock-${local.account_id}"
  bucket_name         = var.bucket_name == "" ? local.default_bucket_name : var.bucket_name
  table_name          = var.table_name == "" ? local.default_table_name : var.table_name

  # these locals are actually used in the created resources
  bucket_arn = "arn:aws:s3:::${local.bucket_name}"
  table_arn  = "arn:aws:dynamodb:${local.region}:${local.account_id}:table/${local.table_name}"
}

resource "aws_iam_policy" "cicd_policy" {
  name   = "${var.name}-backend-cicd"
  tags   = var.tags
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": "${local.bucket_arn}"
        },
        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:PutItem",
                "dynamodb:GetItem",
                "dynamodb:DeleteItem"
            ],
            "Resource": "${local.dynamodb_table_arn}"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": "${local.bucket_arn}/*"
        }
    ]
}
EOF
}
