# helm-wrapper
**helm-wrapper** is a tool that wraps Kubernetes Helm to simplify helm/tiller version and namespace management.


## Installation

```
  # remove old helm if it exists
  sudo rm -rf /usr/local/bin/helm || true

  # install helm wrapper
  curl https://raw.githubusercontent.com/cradlepoint/helm-wrapper/master/helm -o helm
  chmod +x ./helm
  sudo mv ./helm /usr/local/bin/helm

  # install all helm versions that are installed on your various servers
  HELM_VERSIONS=(v2.12.0 v2.12.1 v2.12.2 v2.12.3 v2.13.0 v2.13.1)
  for HELM_VERSION in "${HELM_VERSIONS[@]}"; do
      sudo rm -rf /usr/local/bin/helm-${HELM_VERSION} || true
      curl http://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -o helm.tar.gz
      tar -xvf helm.tar.gz
      sudo mv linux-amd64/helm /usr/local/bin/helm-${HELM_VERSION}
      rm -rf helm.tar.gz linux-amd64 || true
  done
```