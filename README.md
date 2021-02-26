# OpenShift Container Storage Demos
This repo contains demos for OCS. The demos are setup to be run from a shell script. 
This script formats the output to focus on the key message, cleans up the environment before re-building it.
The oc command for the formatted output is found using `which oc`.
By default the demo script will query openshift for the base domain.

## Available demos:
* Photo Album - Object Bucket Claim

## Run all demos:
`./demo-all.sh`

## Run a single demo:
`./photo-album/demo.sh`
