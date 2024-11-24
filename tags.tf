locals {
  tags = merge(
    {
      git-commit-sha = var.TFC_CONFIGURATION_VERSION_GIT_COMMIT_SHA
      git-tag = var.TFC_CONFIGURATION_VERSION_GIT_TAG
      git-branch = var.TFC_CONFIGURATION_VERSION_GIT_BRANCH
      run-id = var.TFC_RUN_ID
    },
    var.static_tags,
    var.dynamic_tags
  )
}
