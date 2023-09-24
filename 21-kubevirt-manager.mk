.PHONY: kubevirt-manager/up
kubevirt-manager/up: \
	kubevirt-manager/install

.PHONY: kubevirt-manager/install
kubevirt-manager/install:
	kubectl apply -f https://raw.githubusercontent.com/kubevirt-manager/kubevirt-manager/main/kubernetes/bundled.yaml
	while ! kubectl wait -n kubevirt-manager deploy/kubevirt-manager --for=condition=available; do echo waiting...; done

.PHONY: kubevirt-manager/port-forward
kubevirt-manager/port-forward: PORT = 8080
kubevirt-manager/port-forward:
	kubectl port-forward -n kubevirt-manager svc/kubevirt-manager $(PORT):8080
