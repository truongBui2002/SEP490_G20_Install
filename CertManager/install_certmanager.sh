#!/bin/bash
set -e

NAMESPACE=cert-manager
HELM_REPO=jetstack
HELM_REPO_URL=https://charts.jetstack.io
HELM_CHART=cert-manager
RELEASE_NAME=cert-manager
HELM_VERSION=v1.16.2

if ! command -v helm &> /dev/null
then
    exit 1
fi

helm repo add $HELM_REPO $HELM_REPO_URL --force-update
helm repo update

if ! kubectl get namespace $NAMESPACE &> /dev/null
then
    kubectl create namespace $NAMESPACE
fi

helm install \
  $RELEASE_NAME $HELM_REPO/$HELM_CHART \
  --namespace $NAMESPACE \
  --version $HELM_VERSION \
  --set installCRDs=true