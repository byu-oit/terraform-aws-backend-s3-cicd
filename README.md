![Latest GitHub Release](https://img.shields.io/github/v/release/byu-oit/terraform-aws-backend-s3-cicd?sort=semver)

# Terraform AWS Backend S3 CI/CD
Creates the IAM policies needed to deploy/use [Terraform AWS Backend S3](https://github.com/byu-oit/terraform-aws-backend-s3)

#### [New to Terraform Modules at BYU?](https://devops.byu.edu/terraform/index.html)

## Usage
```hcl
module "backend-s3-cicd" {
  source = "github.com/byu-oit/terraform-aws-backend-s3-cicd?ref=v1.0.0"
}
```

## Requirements
* Terraform version 1.0.0 or greater

## Inputs
| Name | Type  | Description | Default |
| --- | --- | --- | --- |
| bucket_name | terraform-state-storage-<account_number> | S3 bucket name for state file storage |
| dynamodb_table_name | terraform-state-lock-<account_number> | DynamoDB table name for state file locking |

## Outputs
| Name | Type | Description |
| --- | --- | --- |
| creation_policy | [IAM Policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | Permissions needed to deploy [Terraform AWS Backend S3](https://github.com/byu-oit/terraform-aws-backend-s3) |
| use_policy | [IAM Policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | Permissions needed to deploy a project that uses a `backend "s3" {}` |
