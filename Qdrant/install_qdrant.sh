#!/bin/bash
set -e

NAMESPACE=apps
HELM_REPO=qdrant
HELM_REPO_URL=https://qdrant.to/helm
HELM_CHART=qdrant/qdrant
RELEASE_NAME=qdrant
VALUES_FILE=qdrant-values.yaml

helm repo add $HELM_REPO $HELM_REPO_URL --force-update
helm repo update

if ! kubectl get namespace $NAMESPACE &> /dev/null
then
    kubectl create namespace $NAMESPACE
fi

helm show values $HELM_REPO/$HELM_CHART > $VALUES_FILE

helm install $RELEASE_NAME $HELM_REPO/$HELM_CHART -f $VALUES_FILE --namespace $NAMESPACE