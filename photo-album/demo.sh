demo_home=$( cd "$(dirname "$([[ $0 != $BASH_SOURCE ]] && echo "$BASH_SOURCE" || echo "$0" )")" ; pwd -P )
source $demo_home/format.sh $@
cd $demo_home; perl -pe "s/\{+domain\}+/$domain/g" app.yaml.tmpl > app.yaml 

__ "Object Bucket Demo"
___ "Cleanup existing environment"
oc delete --ignore-not-found=1 -f app.yaml
oc delete --ignore-not-found=1 bc photo-album -n demo
___ "Import dependencies and create build config"
oc import-image ubi8/python-38 --from=registry.redhat.io/ubi8/python-38 --confirm -n demo
__ " * Deploy application"
oc create -f app.yaml
__ " * Build the application image"
oc new-build --binary --strategy=docker --name photo-album -n demo
oc start-build photo-album --from-dir . -F -n demo
cd -
