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

.PHONY: testvm/start
testvm/start:
	virtctl start testvm

.PHONY: testvm/stop
testvm/stop:
	virtctl stop testvm

.PHONY: testvm/console
testvm/console:
	@virtctl console testvm
