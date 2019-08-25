#!/usr/bin/env bash

echo "preparing..."
export GCLOUD_PROJECT=$(gcloud config get-value project)
export INSTANCE_REGION=us-central1
export INSTANCE_ZONE=us-central1-a
export CLUSTER_NAME=cloudrun-test
export SERVICE_ACCOUNT_NAME=cloudrun-test
export TOPIC_NAME=cloudrun-scheduler-topic

echo "config"
gcloud config set project ${GCLOUD_PROJECT}
gcloud config set compute/zone ${INSTANCE_ZONE}

echo "enable pubsub"
gcloud services enable pubsub.googleapis.com

echo "create topic"
gcloud pubsub topics create ${TOPIC_NAME}
