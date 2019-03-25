# helm-wrapper
**helm-wrapper** is a tool that wraps [Kubernetes Helm](https://github.com/helm/helm) to simplify helm/tiller version and namespace management.

## Why do I need helm-wrapper?

Given that:
* [Helm](https://github.com/helm/helm) has two parts: a client (`helm`) and a sever (`tiller`)
* In many cases the the client and the server versions must match for a `helm` call to succeed.
* A common Helm [security best practice](https://engineering.bitnami.com/articles/helm-security.html) is installing a `tiller` server in each Kubernetes namespace that `helm` will be used.
* Many organizations use multiple clusters.

Keeping the same `tiller` version across all clusters and all namespaces is impractical. This forces users and build scripts to use several different `helm` client versions - a problem that is frustrating and error-prone.

**helm-wapper** solve this problem by negotiating with the target `tiller`, determining its version, and then using the corresponding `helm` client for each request. It does this automatically so the user/script does not need to be modified from its current `helm` usage.


## Installation

```
  # remove old helm if it exists
  sudo rm -rf /usr/local/bin/helm

  # install helm wrapper
  curl https://raw.githubusercontent.com/cradlepoint/helm-wrapper/master/helm -o helm
  chmod +x ./helm
  sudo mv ./helm /usr/local/bin/helm

  # download helm installer
  curl https://raw.githubusercontent.com/cradlepoint/helm-wrapper/master/install-helm-versions.sh -o install-helm-versions.sh
  chmod +x ./install-helm-versions.sh

  # install desired helm versions
  ./install-helm-versions.sh [ver1 ver2 verN]
  # example: ./install-helm-versions.sh 2.13.0 2.13.1
  # example: ./install-helm-versions.sh 2.12.1

```
