provider "aws" {
  version = "~> 3.0"
  region  = "us-west-2"
}

locals {
  name = "my_project"
  env  = "dev"
  tags = {
    env              = local.env
    data-sensitivity = "public"
    repo             = "https://github.com/byu-oit/${local.name}"
  }
}

module "backend-s3-cicd" {
  source = "github.com/byu-oit/terraform-aws-backend-s3-cicd?ref=v1.0.0"
}

module "gha_role" {
  source                         = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version                        = "4.13.2"
  create_role                    = true
  role_name                      = "${local.name}-${var.env}-gha"
  role_permissions_boundary_arn  = module.acs.role_permissions_boundary.arn
  tags                           = local.tags
  provider_url                   = "token.actions.githubusercontent.com"
  oidc_fully_qualified_audiences = ["sts.amazonaws.com"]
  oidc_subjects_with_wildcards   = ["repo:byu-oit/${local.name}:*"]
  number_of_role_policy_arns     = 1
  role_policy_arns               = [module.backend-s3-cicd.use_policy.arn]
}
