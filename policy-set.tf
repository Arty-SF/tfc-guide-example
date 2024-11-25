# @see https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/policy_set

provider "tfe" {
  token        = var.tfe-token
  organization = "artysf-org"
}

data "tfe_slug" "training-policy-set" {
  source_path = "./policies/training-policy-set"
}

resource "tfe_policy_set" "training-policy-set" {
  name        = "training-policy-set"
  description = "https://hashicorp-terraform.awsworkshop.io/060_sentinel/6-policy-quickstart.html"
  # since tfe has it
  # organization = "artysf-org"
  workspace_ids = ["ws-JpWyndBw3tPSxg6H"]
  kind          = "sentinel"

  // reference the tfe_slug data source.
  slug = data.tfe_slug.training-policy-set
}

# working example
#resource "tfe_policy" "test" {
#  name         = "training-policy-set"
#  description  = "https://hashicorp-terraform.awsworkshop.io/060_sentinel/6-policy-quickstart.html"
#  organization = "artysf-org"
#  kind         = "sentinel"
#  policy       = "main = rule { true }"
#  enforce_mode = "hard-mandatory"
#}