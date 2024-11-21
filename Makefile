#!make

# $(VERBOSE).SILENT:
.ONESHELL:

DEV_ENV := dev
GROUP_NAME := default

# Check of presence of .env: either via wildcard (or like the next condition)
# ... or via "-include"
ifeq ("$(shell test -e .env && echo 1)", "1")
	-include .env
endif

ifdef ${TFC_CURRENT_ENV}
	DEV_ENV := ${TFC_CURRENT_ENV}
endif

ifdef TFC_GROUP_NAME
	GROUP_NAME := ${TFC_GROUP_NAME}
endif

define hcp_api_list_vars
	$(1) := $(shell curl \
	  --get \
	  --header "Authorization: Bearer ${HCP_API_TOKEN}" \
  	  --header "Content-Type: application/vnd.api+json" \
  	  --data-urlencode "filter[organization][name]=artysf-org" \
  	  --data-urlencode "filter[workspace][name]=tfc-guide-example" \
	  "https://app.terraform.io/api/v2/vars" 2>/dev/null | jq '.' )
endef

# @see https://jqplay.org/s/LZzPUNZ9WaRKZIL
# @see https://www.gnu.org/software/make/manual/html_node/Eval-Function.html#Eval-Function
define hcp_api_update_aws_credentials
	$(eval $(call hcp_api_list_vars,CLOUD_VARS))

	$(shell (echo "${CLOUD_VARS}" ) > test.txt )
endef

YOR_COST_ALLOCATION_TAGS := '{ "group-name" : "$(GROUP_NAME)" }'

.PHONY: help yor fmt hcp-api-list-vars setup

.PHONY: help
help: ## Show available commands
	@echo "Available commands:"
	@echo
	@sed -n -E -e 's|^([A-Za-z0-9/_-]+):.+## (.+)|\1@\2|p' $(MAKEFILE_LIST) | column -s '@' -t

yor: ## [Deprecated] Auto-append tags via `yor` CLI tool
	YOR_SIMPLE_TAGS=$(YOR_COST_ALLOCATION_TAGS) \
	yor tag -d . --tag-prefix 'ci:' --config-file ./yor.yaml --skip-tags 'git_last_modified_by,git_modifiers'

fmt: ## Format TF files
	terraform fmt -recursive .

hcp-api-list-vars: ## List variables in HCP Cloud
	$(hcp_api_list_vars)

## Update AWS access token variables in HCP Cloud
setup: ## Initialize project locally
	[ -e '.env' ] || cp '.env.example' '.env'
ifeq ($(HCP_API_TOKEN),)
	@echo Warning: HCP_API_TOKEN isn\'t defined\; continue? [Type token value/n]
	@read -r line; if [ $$line = "n" ]; then echo aborting; exit 1 ; else echo $$line | xargs -I '{}' sed -ri 's/^(HCP_API_TOKEN).*/\1={}/g' .env ; fi
	$(source .env)
endif
	$(hcp_api_update_aws_credentials)
