#!/bin/bash
set -e

NAMESPACE=apps
HELM_REPO=bitnami
HELM_REPO_URL=https://charts.bitnami.com/bitnami
HELM_CHART=redis
RELEASE_NAME=redis
VALUES_FILE=redis-values.yaml

helm repo add $HELM_REPO $HELM_REPO_URL --force-update
helm repo update

if ! kubectl get namespace $NAMESPACE &> /dev/null
then
    kubectl create namespace $NAMESPACE
fi

helm install redis bitnami/redis --set volumePermissions.enabled=true,replica.replicaCount=2,auth.enabled=true,auth.password=icodervn,master.livenessProbe.enabled=false,master.readinessProbe.enabled=false,replica.livenessProbe.enabled=false -n $NAMESPACE

helm install redis bitnami/redis -f $VALUES_FILE -n $NAMESPACE