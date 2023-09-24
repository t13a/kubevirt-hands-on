.PHONY: kind/up
kind/up: \
	kind/create

.PHONY: kind/down
kind/down: \
	kind/delete

export KIND_CLUSTER_NAME := kubevirt-hands-on
export KUBECONFIG := $(PWD)/.kube/config

kind_is_created = kind get clusters | grep -q '^$(KIND_CLUSTER_NAME)$$'

.PHONY: kind/create
kind/create:
	if ! $(kind_is_created); then kind create cluster; fi

.PHONY: kind/delete
kind/delete:
	if $(kind_is_created); then kind delete cluster; fi

.PHONY: kind/cluster-name
kind/cluster-name:
	@echo $(KIND_CLUSTER_NAME)

.PHONY: kind/kubeconfig
kind/kubeconfig:
	@echo $(KUBECONFIG)

kind_container_ip_address = $(shell docker network inspect kind \
	| jq -re --arg name '$(KIND_CLUSTER_NAME)-control-plane' '.[0].Containers[]|select(.Name==$$name).IPv4Address|split("/")[0]')

.PHONY: kind/container-ip-address
kind/container-ip-address:
	@echo $(kind_container_ip_address)
