#!/bin/bash

# grab global variables
source vars

DOCKER=$(which docker)

# build image and tag with build tag (MonthDayYearMinute)
$DOCKER build --pull -t ${IMAGE_NAME}:${NZBGET_VERSION} .

# add latest tag
$DOCKER tag ${IMAGE_NAME}:${NZBGET_VERSION} ${IMAGE_NAME}:latest
