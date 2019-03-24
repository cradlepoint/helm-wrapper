#!/bin/bash

#####
# install script for cradlepoint helm wrapper
#####

set -e # exit on any error

HELM_VERSIONS=(v2.11.0 v2.12.0 v2.12.1 v2.12.2 v2.12.3 v2.13.0 v2.13.1)
if (uname -s | grep -q Darwin); then
    OS=darwin
else
    OS=linux
fi

for HELM_VERSION in "${HELM_VERSIONS[@]}"; do
    if [ $OS = "darwin" ] ; then
        helmver=/usr/local/Cellar/kubernetes-helm/${HELM_VERSION:1:${#HELM_VERSION}}
        echo "deleting brew installed helm at ${helmver} ..."
        sudo rm -rf $helmver || true
    fi

    helmver=/usr/local/bin/helm-${HELM_VERSION}
    echo "deleting helm at ${helmver} ..."
    sudo rm -rf $helmver || true

    echo "installing helm ${HELM_VERSION}..."
    curl http://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-${OS}-amd64.tar.gz -o helm.tar.gz
    tar -xvf helm.tar.gz
    sudo mv ${OS}-amd64/helm /usr/local/bin/helm-${HELM_VERSION}
    rm -rf helm.tar.gz ${OS}-amd64 || true
done
