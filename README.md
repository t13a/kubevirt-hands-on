# KubeVirt Hands-on

A KubeVirt hands-on resource.

# Features

- Follow [official quickstart with kind](https://kubevirt.io/quickstart_kind/).
- Built-in [kubevirt-manager](https://kubevirt-manager.io/).

# Getting started

## Prerequisites

- Docker
- Nix

## Setup

```sh
$ nix-shell
[nix-shell:~kubevirt-hands-on]$ make up
[nix-shell:~kubevirt-hands-on]$ eval $(make export)
```

## Connect to VM

```sh
[nix-shell:~kubevirt-hands-on]$ make testvm/console
Successfully connected to testvm console. The escape sequence is ^]
...
  ____               ____  ____
 / __/ __ ____ ____ / __ \/ __/
/ /__ / // __// __// /_/ /\ \
\___//_//_/  /_/   \____/___/
   http://cirros-cloud.net


login as 'cirros' user. default password: 'gocubsgo'. use 'sudo' for root.
testvm login:
```

## Connect to kubevirt-manager

```sh
[nix-shell:~kubevirt-hands-on]$ make kubevirt-manager/port-forward
kubectl port-forward -n kubevirt-manager svc/kubevirt-manager 8080:8080
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080
...
```

## Teardown

```sh
[nix-shell:~kubevirt-hands-on]$ eval $(make unset)
[nix-shell:~kubevirt-hands-on]$ make down
exit
```
