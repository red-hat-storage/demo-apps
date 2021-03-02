# Output
RED='\033[0;31m'
GREEN='\033[0;32m'
NOC='\033[0m'
export OK='\033[0;32mOK\033[0m'
export ERROR='\033[0;31mERROR\033[0m'

# Required Arguments
if [ -z "$domain" ]; then 
  if [ -n "$1" ]; then
    export domain=$1;
  elif [ -n "$OCP_APPS_DOMAIN" ]; then
    export domain=$OCP_APPS_DOMAIN;
  else
    ingress=$($(which oc) get --namespace openshift-ingress-operator ingresscontrollers/default -o jsonpath='{.status.domain}')
    if [ -n "$ingress" ]; then
      export domain=$ingress;
    else
      printf "[ $ERROR ] Please provide OCP apps domain:\n\t$0 apps.ocp.example.com\nor\n\texport OCP_APPS_DOMAIN=apps.ocp.example.com; $0\n"; 
      exit 1; 
    fi
  fi
else 
  # Already setup
  return 0
fi
printf "[ $OK    ] Using $domain as our base domain\n"

function oc {
 args=$@
 cmd="$(which oc) $args"
 out=$($cmd 2>&1)
if [ $? -eq 0 ]; then
  if [ "$1" == "process" ]; then
    printf "[ $OK    ] oc $args\nprocessed template\n" >&2
    echo "$out"
  elif [ "$1" == "import-image" ]; then
    printf "[ $OK    ] oc $args\n$2 imported\n" >&2
  elif [ "$1" == "start-build" ]; then
    printf "[ $OK    ] oc $args\n$2 setup\n" >&2
  elif [ "$1" == "new-build" ]; then
    printf "[ $OK    ] oc $args\n$5 built\n" >&2
  else
    printf "[ $OK    ] oc $args\n"
    echo "$out"
  fi
else
  printf "[ $ERROR ] oc $args\n"
fi
}

function scp {
 args=$@
 cmd=$(which scp)
 out=$($cmd -o "StrictHostKeyChecking no" $args)
if [ $? -eq 0 ]; then
  printf "[ $OK    ] scp $args\nDone\n"
else
  printf "[ $ERROR ] $cmd $args\n"
fi
}

function ssh {
 args=$@
 cmd="$(which ssh) $args"
 out=$($cmd -o "StrictHostKeyChecking no")
if [ $? -eq 0 ]; then
  printf "[ $OK    ] ssh $args\nDone\n"
else
  printf "[ $ERROR ] $cmd\n"
fi
}

function __ {
 msg=$1
 echo; echo "$msg"
}

function ___ {
 msg=$1
 sec=$2
 echo; echo " * $msg"
 if [ -n "$2" ]; then
   sleep $sec
 else
   echo; read -p "Press any key to continue... " -n1 -s
 fi
 echo;
}

home=$( cd "$(dirname "$BASH_SOURCE")" ; pwd -P )
oc create namespace demo > /dev/null 2>&1
oc project demo > /dev/null 2>&1

