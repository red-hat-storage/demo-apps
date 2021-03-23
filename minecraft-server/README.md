# Minecraft Server Block Storage Demo
This demo shows the use of RBD storage for a server of the popular game Minecraft

# Run the demo
This demo cleans up the environment completely and the redeploys the application and creates the PVC and PV using rbd.

``./demo.sh``

# Deployment
<pre>
$ ./demo.sh
[ <span style="color:green">OK</span>    ] Using apps.ocp.webwim.com as our base domain
[ <span style="color:green">OK</span>    ] oc apply -f /srv/redhat/demo/namespace.yaml
namespace/demo unchanged

Block Storage Demo

 * Cleanup existing environment

Press any key to continue...
[ <span style="color:green">OK</span>    ] oc delete --ignore-not-found=1 -f app.yaml
persistentvolumeclaim "minecraft-server-data" deleted
deploymentconfig.apps.openshift.io "minecraft-server" deleted
route.route.openshift.io "minecraft-server" deleted
service "minecraft-server" deleted

 * Deploy application
[ <span style="color:green">OK</span>    ] oc create -f app.yaml
persistentvolumeclaim/minecraft-server-data created
deploymentconfig.apps.openshift.io/minecraft-server created
route.route.openshift.io/minecraft-server created
service/minecraft-server created
</pre>
