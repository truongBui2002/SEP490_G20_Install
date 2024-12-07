#!/bin/bash
set -e

NAMESPACE=prometheus-stack
HELM_REPO=prometheus-community
HELM_REPO_URL=https://prometheus-community.github.io/helm-charts
HELM_CHART=kube-prometheus-stack
RELEASE_NAME=prometheus-stack

helm repo add $HELM_REPO $HELM_REPO_URL --force-update
helm repo update

if ! kubectl get namespace $NAMESPACE &> /dev/null
then
    kubectl create namespace $NAMESPACE
fi

helm install $RELEASE_NAME $HELM_REPO/$HELM_CHART \
  --set grafana.adminPassword=icodervn \
  --namespace $NAMESPACE \
  --create-namespace