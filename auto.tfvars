# @see https://developer.hashicorp.com/terraform/cloud-docs/run/run-environment#environment-variables
# otherwise @see https://gist.github.com/mattmahn/f46420ba8d740cc008accfde964c2e74

dynamic_tags = {
    git-commit-sha = var.TFC_CONFIGURATION_VERSION_GIT_COMMIT_SHA
    git-tag = var.TFC_CONFIGURATION_VERSION_GIT_TAG
    git-branch = var.TFC_CONFIGURATION_VERSION_GIT_BRANCH
    run-id = var.TFC_RUN_ID
}
