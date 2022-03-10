![Latest GitHub Release](https://img.shields.io/github/v/release/byu-oit/terraform-aws-backend-s3-cicd?sort=semver)

# Terraform AWS Backend S3 CI/CD
Creates the IAM policies needed to deploy projects that use `backend "s3" {}`. To create these backends, see [Terraform AWS Backend S3](https://github.com/byu-oit/terraform-aws-backend-s3).

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
| name | string | Used to prefix created resource names | |
| tags | map(string) | A map of AWS Tags to attach to each resource created | {} |
| bucket_name | string | S3 bucket name for state file storage | terraform-state-storage-<account_number> |
| dynamodb_table_name | string | DynamoDB table name for state file locking | terraform-state-lock-<account_number> |

## Outputs
| Name | Type | Description |
| --- | --- | --- |
| cicd_policy | [IAM Policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | Permissions needed to deploy a project that uses a `backend "s3" {}` |
