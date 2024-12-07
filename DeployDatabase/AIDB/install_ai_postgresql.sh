#!/bin/bash
set -e

NAMESPACE=apps
HELM_REPO=bitnami
HELM_REPO_URL=https://charts.bitnami.com/bitnami
HELM_CHART=bitnami/postgresql
RELEASE_NAME=aidb
VALUES_FILE=ai-postgresql-values.yaml

helm repo add $HELM_REPO $HELM_REPO_URL --force-update
helm repo update

if ! kubectl get namespace $NAMESPACE &> /dev/null
then
    kubectl create namespace $NAMESPACE
fi

helm show values $HELM_REPO/$HELM_CHART > $VALUES_FILE

helm install $RELEASE_NAME $HELM_REPO/$HELM_CHART \
  --set volumePermissions.enabled=true \
  --namespace $NAMESPACE \
  -f $VALUES_FILE