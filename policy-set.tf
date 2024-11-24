# @see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/policy_set

data "tfe_slug" "this" {
  source_path = "policies/training-policy-set"
}

resource "tfe_policy_set" "this" {
  name         = "training-policy-set"
  description  = "https://hashicorp-terraform.awsworkshop.io/060_sentinel/6-policy-quickstart.html"
  organization = "artysf-org"

  // reference the tfe_slug data source.
  slug = data.tfe_slug.this
}