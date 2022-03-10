terraform {
  required_version = "1.0.0"
}

provider "aws" {
  region = "us-west-2"
}

module "ci_test" {
  source = "../../"
  name   = "ci_test"
}

output "cicd_policy_arn" {
  value = module.ci_test.cicd_policy.arn
}
