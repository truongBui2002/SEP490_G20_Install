#!/bin/bash
set -e

NAMESPACE=harbor
HELM_REPO=harbor
HELM_REPO_URL=https://helm.goharbor.io
HELM_CHART=harbor/harbor
RELEASE_NAME=harbor
VALUES_FILE=harbor-values.yaml

helm repo add $HELM_REPO $HELM_REPO_URL --force-update
helm repo update

helm show values $HELM_REPO/$HELM_CHART > $VALUES_FILE

helm install $RELEASE_NAME $HELM_REPO/$HELM_CHART --namespace $NAMESPACE --create-namespace --values $VALUES_FILE

docker push hub.icoder.vn/k8s/nginx:latest

kubectl create secret docker-registry harbor-secret \
  --docker-server=hub.icoder.vn \
  --docker-username=admin \
  --docker-password=icodervn \
  --docker-email=buivantruong16082002@gmail.com \
  -n apps
