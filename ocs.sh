home=$( cd "$(dirname "$0")" ; pwd -P )
source $home/format.sh
oc project demo > /dev/null 2>&1
oc apply -f $home/namespace.yaml

# __ "CephFS Data Retention Demo"
# ___ "Cleanup existing environment"
# pvname=$(/usr/local/bin/oc get pvc pihole-data -n demo -o json | jq -r '.spec.volumeName')
# out=$(/usr/local/bin/oc patch pv $pvname -p '{"spec":{"persistentVolumeReclaimPolicy":"Retain"}}')
# oc delete -f $home/pihole/app.yaml
# ___ "PV is Released"
# out=$(/usr/local/bin/oc patch pv $pvname --type json -p $'- op: remove\n  path: /spec/claimRef')
# ___ "PV is Available"
# oc create -f $home/pihole/app.yaml
# echo;


# __ "Block Storage Demo"
# ___ "Cleanup existing environment"
# oc delete -f $home/minecraft-server/app.yaml
# ___ "Deploy Minecraft Server"
# oc create -f $home/minecraft-server/app.yaml
# ___ "Verify Storage" 60
# oc rsh $(/usr/local/bin/oc get pods -l "app=minecraft-server" -o name) df /data
# echo;


__ "Object Bucket Demo"
___ "Cleanup existing environment"
cd $home/photo-album/
oc delete -f app.yaml
oc delete bc photo-album -n demo
oc delete bc python-app -n demo
___ "Import dependencies and create build config"
oc import-image ubi8/python-38 --from=registry.redhat.io/ubi8/python-38 --confirm -n demo
__ " * Deploy application"
oc create -f app.yaml
__ " * Build the application image"
oc new-build --binary --strategy=docker --name python-app -n demo
oc start-build python-app --from-file python-app.Dockerfile -F -n demo
oc new-build --binary --strategy=docker --name photo-album -n demo
oc start-build photo-album --from-dir . -F -n demo
cd $home
