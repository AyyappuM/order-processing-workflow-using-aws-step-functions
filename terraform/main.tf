provider "aws" {
  region  = local.region
  profile = "a1"
}

data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  region = "ap-south-1"
}
