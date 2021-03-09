demo_home=$( cd "$(dirname "$([[ $0 != $BASH_SOURCE ]] && echo "$BASH_SOURCE" || echo "$0" )")" ; pwd -P )
source $demo_home/format.sh $@
cd $demo_home; perl -pe "s/\{+domain\}+/$domain/g" app.yaml.tmpl > app.yaml 

__ "CephFS Data Retention Demo"
___ "Cleanup existing environment"
pvname=$($(which oc) get pvc pihole-data -n demo -o json | jq -r '.spec.volumeName')
out=$($(which oc) patch pv $pvname -p '{"spec":{"persistentVolumeReclaimPolicy":"Retain"}}')
oc delete -f $demo_home/app.yaml
___ "PV is Released"
out=$($(which oc) patch pv $pvname --type json -p $'- op: remove\n  path: /spec/claimRef')
___ "PV is Available"
oc create -f $demo_home/app.yaml
echo;
