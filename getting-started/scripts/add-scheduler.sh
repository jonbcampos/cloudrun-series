#!/usr/bin/env bash

echo "preparing..."
export GCLOUD_PROJECT=$(gcloud config get-value project)
export INSTANCE_REGION=us-central1
export INSTANCE_ZONE=us-central1-a
export CLUSTER_NAME=cloudrun-test
export SERVICE_ACCOUNT_NAME=cloudrun-test
export SCHEDULER_NAME=cloudrun-scheduler
export TOPIC_NAME=cloudrun-scheduler-topic

echo "config"
gcloud config set project ${GCLOUD_PROJECT}
gcloud config set compute/zone ${INSTANCE_ZONE}

echo "enable scheduler"
gcloud services enable cloudscheduler.googleapis.com

echo "create schedule"
gcloud scheduler jobs create pubsub ${SCHEDULER_NAME} \
    --schedule="* * * * *" \
    --topic=${TOPIC_NAME} \
    --message-body="scheduler system"

