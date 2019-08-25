#!/usr/bin/env bash

echo "preparing..."
export GCLOUD_PROJECT=$(gcloud config get-value project)
export INSTANCE_ZONE=us-central1-a

echo "update local env"
gcloud components update

echo "login to gcloud"
gcloud auth login

echo "set project id"
gcloud config set project ${GCLOUD_PROJECT}

echo "install kubectl"
gcloud components install kubectl

echo "login to kubectl"
gcloud auth application-default login

echo "login to gcp docker"
gcloud auth configure-docker
