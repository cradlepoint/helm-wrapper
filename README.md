# helm-wrapper
**helm-wrapper** is a tool that wraps [Kubernetes Helm](https://github.com/helm/helm) to simplify helm/tiller version management.


> :warning: **Helm v2 is no longer supported.  This repository is now archived.**


## Why do I need helm-wrapper?
When using `helm`, have you ever seen this message, or something similar?
```
Error: incompatible versions client[v2.9.1] server[v2.8.2]
```

Given that:
* [Helm](https://github.com/helm/helm) has two parts: a client (`helm`) and a server (`tiller`)
* In many cases the client and the server versions must match for a `helm` call to succeed.
* A common Helm [security best practice](https://engineering.bitnami.com/articles/helm-security.html) is installing a `tiller` server  in each Kubernetes namespace that `helm` will be used.
* Many organizations use multiple clusters.

Keeping the same `tiller` version across all clusters and all namespaces at all times is impractical. This forces users and build scripts to use several different `helm` client versions - a problem that is frustrating and error-prone.

**helm-wapper** solve this problem by negotiating with the target `tiller`, determining its version, and then using the corresponding `helm` client for each request. It does this automatically so the user/script does not need to be modified from its current `helm` usage.


### Tiller Namespace
For `helm` commands that call the server, **helm-wrapper** must first calculate the `tiller` namespace so that it can determine the installed `tiller` version.  It uses the following algorithm to determine the `tiller` namespace:
1. use `--tiller-namespace` if specified in command
2. use TILLER_NAMESPACE environment variable if it is set
3. use the current `kubectl config` ("kubeconfig") namespace if it is set &larr; this is divergent behavior from `helm`, but simplifies working in a tiller-per-namespace environment
4. use the default `helm` namespace, `kube-system`


## Installation

```
  HELM_WRAPPER_VERSION=v1.0.0

  # remove old helm if it exists
  sudo rm -rf /usr/local/bin/helm

  # install helm wrapper
  curl https://raw.githubusercontent.com/cradlepoint/helm-wrapper/${HELM_WRAPPER_VERSION}/helm -o helm
  chmod +x ./helm
  sudo mv ./helm /usr/local/bin/helm

  # download helm installer
  curl https://raw.githubusercontent.com/cradlepoint/helm-wrapper/${HELM_WRAPPER_VERSION}/install-helm-versions.sh -o install-helm-versions.sh
  chmod +x ./install-helm-versions.sh

  # use installer to install desired helm versions (https://github.com/helm/helm/releases)
  # usage: ./install-helm-versions.sh [ver1 ver2 verN]
  ./install-helm-versions.sh 2.12.3 2.13.1
```
