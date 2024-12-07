#!/bin/bash
set -e

NAMESPACE=apps
HELM_REPO=elastic
HELM_REPO_URL=https://helm.elastic.co
HELM_CHART=kibana
RELEASE_NAME=kibana
VALUES_FILE=values.yaml

helm repo add $HELM_REPO $HELM_REPO_URL --force-update
helm repo update

if ! kubectl get namespace $NAMESPACE &> /dev/null
then
    kubectl create namespace $NAMESPACE
fi

helm install $RELEASE_NAME $HELM_REPO/$HELM_CHART -f $VALUES_FILE --namespace $NAMESPACE --create-namespace