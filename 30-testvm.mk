.PHONY: testvm/up
testvm/up: \
	testvm/create \
	testvm/start

.PHONY: testvm/down
testvm/down: \
	testvm/stop \
	testvm/delete

.PHONY: testvm/create
testvm/create:
	kubectl apply -f https://kubevirt.io/labs/manifests/vm.yaml

.PHONY: testvm/delete
testvm/delete:
	kubectl delete -f https://kubevirt.io/labs/manifests/vm.yaml  --force --grace-period=0 --ignore-not-found

testvm_is_running = [ "$$(kubectl get vm/testvm -o jsonpath={.spec.running})" == true ]

.PHONY: testvm/start
testvm/start:
	if ! $(testvm_is_running); then virtctl start testvm; fi
	while ! kubectl wait vm/testvm --for=jsonpath={.status.ready}=true; do echo waiting...; done

.PHONY: testvm/stop
testvm/stop:
	if $(testvm_is_running); then virtctl stop testvm; fi
