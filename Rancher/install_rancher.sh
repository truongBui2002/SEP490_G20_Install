#!/bin/bash
set -e

NAMESPACE=cattle-system
HELM_REPO=rancher-stable
HELM_REPO_URL=https://releases.rancher.com/server-charts/stable
HELM_CHART=rancher
RELEASE_NAME=rancher

helm repo add $HELM_REPO $HELM_REPO_URL --force-update
helm repo update

if ! kubectl get namespace $NAMESPACE &> /dev/null
then
    kubectl create namespace $NAMESPACE
fi

helm install $RELEASE_NAME $HELM_REPO/$HELM_CHART \
    --namespace $NAMESPACE \
    --set hostname=rancher.icoder.vn \
    --set bootstrapPassword=icodervn