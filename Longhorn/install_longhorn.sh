#!/bin/bash
set -e

NAMESPACE=longhorn-system
HELM_REPO=longhorn
HELM_REPO_URL=https://charts.longhorn.io
HELM_CHART=longhorn/longhorn
RELEASE_NAME=longhorn
HELM_VERSION=1.2.2
VALUES_FILE=longhorn-values.yaml

helm repo add $HELM_REPO $HELM_REPO_URL --force-update
helm repo update

if ! kubectl get namespace $NAMESPACE &> /dev/null
then
    kubectl create namespace $NAMESPACE
fi

helm install $RELEASE_NAME $HELM_REPO/$HELM_CHART \
  --namespace $NAMESPACE \
  --version $HELM_VERSION \
  --values $VALUES_FILE

kubectl apply -f SEP490_G20_Install/Longhorn/longhorn-storageclass-retain.yaml
kubectl apply -f SEP490_G20_Install/Longhorn/longhorn-storageclass-delete.yaml