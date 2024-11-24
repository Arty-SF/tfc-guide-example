data "tfe_slug" "this" {
  source_path = "policies/training-policy-set"
}

resource "tfe_workspace" "this" {
  name         = "tfc-guide-example"
  organization = "artysf-org"
}

resource "tfe_policy_set" "this" {
  name          = "training-policy-set"
  description   = "https://hashicorp-terraform.awsworkshop.io/060_sentinel/6-policy-quickstart.html"
  organization  = "artysf-org"
  workspace_ids = [tfe_workspace.this.id]

  // reference the tfe_slug data source.
  slug = data.tfe_slug.this
}