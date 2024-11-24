data "tfe_slug" "this" {
  source_path = "policies/training-policy-set"
}

data "tfe_policy_set" "this" {
  name         = "training-policy-set"
  organization = "artysf-org"
}

import {
  to = tfe_policy_set.this
  id = data.tfe_policy_set.this.id
}

resource "tfe_policy_set" "this" {
  name                = "training-policy-set"
  description         = "https://hashicorp-terraform.awsworkshop.io/060_sentinel/6-policy-quickstart.html"
  organization        = "artysf-org"
  kind                = "sentinel"
  agent_enabled       = true
  policy_tool_version = "latest"
  overridable         = true

  // reference the tfe_slug data source.
  slug = data.tfe_slug.this
}