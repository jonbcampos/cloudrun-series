#!/usr/bin/env bash

echo "preparing..."
export GCLOUD_PROJECT=$(gcloud config get-value project)
export INSTANCE_REGION=us-central1
export INSTANCE_ZONE=us-central1-a
export CLUSTER_NAME=cloudrun-test
export IMAGE_NAME=cloudrun-getting-started

echo "config"
gcloud config set project ${GCLOUD_PROJECT}
gcloud config set compute/zone ${INSTANCE_ZONE}

echo "enable apis"
gcloud services enable \
    container.googleapis.com \
    containerregistry.googleapis.com \
    cloudbuild.googleapis.com

echo "build"
gcloud builds submit --tag gcr.io/${GCLOUD_PROJECT}/${IMAGE_NAME} ../
