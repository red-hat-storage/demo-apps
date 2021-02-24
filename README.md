# OpenShift Container Storage Demos
This repo contains demos for OCS. The demos are setup to be run from a shell script. 
This script formats the output to focus on the key message, cleans up the environment before re-building it.
The oc command for the formatted output is found using `which oc`.

## Available demos:
* Photo Album - Object Bucket Claim

## Run all demos:
Provide the ocp base domain to `demo-all.sh` to replace {{domain}} in `app.yaml.tmpl`.

`./demo-all.sh ocp.example.com`

or

`export OCP_BASEDOMAIN=ocp.example.com; ./demo-all.sh`


## Run a single demo:
Provide the ocp base domain to `[demo]/demo.sh` to replace {{domain}} in `app.yaml.tmpl`.

`./photo-album/demo.sh ocp.example.com`

or

`export OCP_BASEDOMAIN=ocp.example.com; ./photo-album/demo.sh`
