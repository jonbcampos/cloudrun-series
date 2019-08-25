#!/usr/bin/env bash

echo "preparing..."
export GCLOUD_PROJECT=$(gcloud config get-value project)
export INSTANCE_REGION=us-central1
export INSTANCE_ZONE=us-central1-a
export CLUSTER_NAME=cloudrun-test
export PROJECT_NUMBER=<your-project-number>
export TOPIC_NAME=cloudrun-scheduler-topic
export SUBSCRIPTION_NAME=cloudrun-scheduler-subscription
export SERVICE_URL=<your-service-url>
export PROJECT_NAME=cloudrun-getting-started
export INVOKER_NAME=cloud-run-pubsub-invoker

echo "config"
gcloud config set project ${GCLOUD_PROJECT}
gcloud config set compute/zone ${INSTANCE_ZONE}
gcloud config set run/region ${INSTANCE_REGION}

echo "create iam binding"
gcloud projects add-iam-policy-binding ${GCLOUD_PROJECT} \
    --member=serviceAccount:service-${PROJECT_NUMBER}@gcp-sa-pubsub.iam.gserviceaccount.com \
    --role=roles/iam.serviceAccountTokenCreator

echo "create service account"
gcloud iam service-accounts create ${INVOKER_NAME} \
    --display-name "Cloud Run Pub/Sub Invoker"

echo "iam roles"
gcloud beta run services add-iam-policy-binding ${PROJECT_NAME} \
    --member=serviceAccount:${INVOKER_NAME}@${GCLOUD_PROJECT}.iam.gserviceaccount.com \
    --role=roles/run.invoker

echo "create subscription"
gcloud beta pubsub subscriptions create ${SUBSCRIPTION_NAME} \
    --topic ${TOPIC_NAME} \
    --push-endpoint=${SERVICE_URL} \
    --push-auth-service-account=${INVOKER_NAME}@${GCLOUD_PROJECT}.iam.gserviceaccount.com
