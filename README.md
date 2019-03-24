# helm-wrapper
**helm-wrapper** is a tool that wraps [Kubernetes Helm](https://github.com/helm/helm) to simplify helm/tiller version and namespace management.


## Installation

```
  # remove old helm if it exists
  sudo rm -rf /usr/local/bin/helm || true

  # install helm wrapper
  curl https://raw.githubusercontent.com/cradlepoint/helm-wrapper/master/helm -o helm
  chmod +x ./helm
  sudo mv ./helm /usr/local/bin/helm

  # install all helm versions that are installed on your various servers
  ./install-cp-helm.sh
```
