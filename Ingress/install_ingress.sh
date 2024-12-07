#!/bin/bash
set -e

NAMESPACE=ingress-nginx
HELM_REPO=ingress-nginx
HELM_REPO_URL=https://kubernetes.github.io/ingress-nginx
HELM_CHART=ingress-nginx/ingress-nginx
RELEASE_NAME=ingress-nginx

helm repo add $HELM_REPO $HELM_REPO_URL --force-update
helm repo update

if ! kubectl get namespace $NAMESPACE &> /dev/null
then
    kubectl create namespace $NAMESPACE
fi

helm upgrade --install $RELEASE_NAME $HELM_REPO/$HELM_CHART --namespace $NAMESPACE --create-namespace