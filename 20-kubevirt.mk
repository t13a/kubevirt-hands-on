.PHONY: kubevirt/up
kubevirt/up: \
	kubevirt/install

kubevirt_version = $(shell git ls-remote -qt --refs https://github.com/kubevirt/kubevirt \
	| cut -d/ -f3- \
	| grep '^v[0-9.]*$$' \
	| sort -V \
	| tail -n1)

.PHONY: kubevirt/install
kubevirt/install: version = $(kubevirt_version)
kubevirt/install:
	kubectl apply -f https://github.com/kubevirt/kubevirt/releases/download/$(version)/kubevirt-operator.yaml
	kubectl apply -f https://github.com/kubevirt/kubevirt/releases/download/$(version)/kubevirt-cr.yaml
	while ! kubectl wait -n kubevirt kv/kubevirt --for=jsonpath={.status.phase}=Deployed; do echo waiting...; done

.PHONY: kubevirt/version
kubevirt/version:
	@echo $(kubevirt_version)
