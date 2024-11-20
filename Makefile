DEV_ENV := dev
GROUP_NAME := default

include .env

ifdef ${TFC_CURRENT_ENV}
	DEV_ENV := ${TFC_CURRENT_ENV}
endif
ifdef TFC_GROUP_NAME
	GROUP_NAME := ${TFC_GROUP_NAME}
endif

YOR_COST_ALLOCATION_TAGS := '{ "group-name" : "$(GROUP_NAME)" }'

.PHONY: yor

yor:
	YOR_SIMPLE_TAGS=$(YOR_COST_ALLOCATION_TAGS) \
	yor tag -d . --tag-prefix 'ci:' --config-file ./yor.yaml --skip-tags 'git_last_modified_by,git_modifiers'
