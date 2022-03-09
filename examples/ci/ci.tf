terraform {
  required_version = "1.0.0"
}

provider "aws" {
  version = "~> 3.0"
  region  = "us-west-2"
}

module "ci_test" {
  source = "../../"
}

output "creation_policy_arn" {
  value = module.ci_test.creation_policy.arn
}

output "use_policy_arn" {
  value = module.ci_test.use_policy.arn
}
