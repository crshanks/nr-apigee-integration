#!/bin/bash
ORG=${APIGEE_ORG:-"default here if not set as an env variable"}
ENV=${APIGEE_ENV:-"default here if not set as an env variable"}

mvn clean install -Ptest -Dorg=$ORG -Denv=$ENV -Dbearer=$(gcloud auth print-access-token)