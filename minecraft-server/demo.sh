demo_home=$( cd "$(dirname "$([[ $0 != $BASH_SOURCE ]] && echo "$BASH_SOURCE" || echo "$0" )")" ; pwd -P )
source $demo_home/format.sh $@
cd $demo_home; perl -pe "s/\{+domain\}+/$domain/g" app.yaml.tmpl > app.yaml 

__ "Block Storage Demo"
___ "Cleanup existing environment"
oc delete --ignore-not-found=1 -f app.yaml
__ " * Deploy application"
oc create -f app.yaml
cd -
