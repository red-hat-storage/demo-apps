# photo-album

Provide the ocp base domain to ocs.sh to replace {{domain}} in app.yaml.tmpl.

`./ocs.sh ocp.mydomain.tld`

or

`export OCP_BASEDOMAIN=ocp.mydomain.tld; ./ocs.sh`

The oc command is found using `which oc`.
