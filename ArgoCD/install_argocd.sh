#!/bin/bash
set -e

NAMESPACE=argocd
HELM_CHART=argo-cd/argo-cd
VALUES_FILE=argocd-values.yaml

if ! command -v helm &> /dev/null
then
    exit
fi

helm repo add argo-cd https://argoproj.github.io/argo-helm
helm repo update

helm install \
  --values $VALUES_FILE \
  argocd $HELM_CHART \
  --namespace $NAMESPACE \
  --create-namespace