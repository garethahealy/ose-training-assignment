#!/usr/bin/env bash

oc annotate namespace default openshift.io/node-selector='region=infra' --overwrite
oc annotate namespace openshift-infra openshift.io/node-selector='region=infra' --overwrite
