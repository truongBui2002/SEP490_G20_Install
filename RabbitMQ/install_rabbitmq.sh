#!/bin/bash
set -e

NAMESPACE=apps
HELM_REPO=bitnami
HELM_REPO_URL=https://charts.bitnami.com/bitnami
HELM_CHART=rabbitmq
RELEASE_NAME=rabbitmq
VALUES_FILE=rabbitmq-values.yaml

helm repo add $HELM_REPO $HELM_REPO_URL --force-update
helm repo update

if ! kubectl get namespace $NAMESPACE &> /dev/null
then
    kubectl create namespace $NAMESPACE
fi

helm show values $HELM_REPO/$HELM_CHART > $VALUES_FILE

helm install $RELEASE_NAME $HELM_REPO/$HELM_CHART \
    --namespace $NAMESPACE \
    --values $VALUES_FILE

helm uninstall $RELEASE_NAME --namespace $NAMESPACE

helm install $RELEASE_NAME $HELM_REPO/$HELM_CHART \
    --namespace $NAMESPACE \
    --set auth.username=icodervn \
    --set auth.password=icodervn \
    --set auth.erlangCookie="Btz2VHBd0C10tSRlWL8x2TWLBphwcrPS" \
    --set metrics.enabled=true