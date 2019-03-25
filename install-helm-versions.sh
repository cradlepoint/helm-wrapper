#!/bin/bash

#####
# install script for cradlepoint helm wrapper
#####

set -e # exit on any error

if (uname -s | grep -q Darwin); then
    OS=darwin
else
    OS=linux
fi

for HELM_VERSION in $*; do
    if [ $OS = "darwin" ] ; then
        helmver=/usr/local/Cellar/kubernetes-helm/${HELM_VERSION}
        echo "deleting brew installed helm at ${helmver} ..."
        sudo rm -rf $helmver || true
    fi

    helmver=/usr/local/bin/helm-v${HELM_VERSION}

    echo "deleting helm at ${helmver} ..."
    sudo rm -rf $helmver || true

    echo "installing helm ${HELM_VERSION}..."
    curl http://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-${OS}-amd64.tar.gz -o helm.tar.gz
    tar -xvf helm.tar.gz
    sudo mv ${OS}-amd64/helm ${helmver}
    rm -rf helm.tar.gz ${OS}-amd64 || true
done
