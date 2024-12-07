#!/bin/bash
set -e

NAMESPACE=elasticsearch
HELM_REPO=elastic
HELM_REPO_URL=https://helm.elastic.co
HELM_CHART=elastic/elasticsearch
RELEASE_NAME=elasticsearch
VALUES_FILE=values.yaml
HELM_VERSION=8.5.1

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
  --values $VALUES_FILE