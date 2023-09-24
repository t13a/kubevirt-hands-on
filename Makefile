.DELETE_ON_ERROR:
MAKEFLAGS += --no-builtin-rules --no-builtin-variables
SHELL := /usr/bin/env bash -euo pipefail

include *.mk

.PHONY: up
up: \
	kind/up \
	kubevirt/up \
	kubevirt-manager/install \
	testvm/up

.PHONY: down
down: \
	kind/down

env_json = jq -n \
		--arg KIND_CLUSTER_NAME '$(KIND_CLUSTER_NAME)' \
		--arg KUBECONFIG '$(KUBECONFIG)' \
		'$$ARGS.named'

.PHONY: export
export:
	@$(env_json) | jq -r 'to_entries|map("\(.key)=\(.value|@sh)")|"export \(join(" "))"'

.PHONY: unset
unset:
	@$(env_json) | jq -r 'to_entries|map(.key)|"unset \(join(" "))"'
