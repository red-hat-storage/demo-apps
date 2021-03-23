# PiHole DNS Filter Demo
This demo shows the use of CephFS for the popular DNS filter appliance pihole.

# Run the demo
The demo first cleans up any existing applicantion and claims while keeping the persistent volume intact.
The volume becomes released but remains attached to the claim from the previous run. After removing the claim the volume becomes available.
At that point the application can be re-created and re-attaching to the previously used PV with it's data.
This works as the PV matches the PVC requirements and is available.

``./demo.sh``

# Deployment
<pre>
$ ./demo.sh
[ <span style="color:green">OK</span>    ] Using apps.ocp.webwim.com as our base domain
[ <span style="color:green">OK</span>    ] oc apply -f /srv/redhat/demo/namespace.yaml
namespace/demo unchanged

CephFS Data Retention Demo

[ <span style="color:green">OK</span>    ] oc delete -f /srv/redhat/demo/pihole/app.yaml
persistentvolumeclaim "pihole-data" deleted
serviceaccount "pihole" deleted
clusterrolebinding.rbac.authorization.k8s.io "pihole-anyuid" deleted
deploymentconfig.apps.openshift.io "pihole" deleted
service "pihole-dns" deleted
service "pihole-web" deleted
route.route.openshift.io "pihole" deleted

 * PV is Released

Press any key to continue... 

 * PV is Available

Press any key to continue... 
[ <span style="color:green">OK</span>    ] oc create -f /srv/redhat/demo/pihole/app.yaml
persistentvolumeclaim/pihole-data created
serviceaccount/pihole created
clusterrolebinding.rbac.authorization.k8s.io/pihole-anyuid created
deploymentconfig.apps.openshift.io/pihole created
service/pihole-dns created
service/pihole-web created
route.route.openshift.io/pihole created
</pre>
