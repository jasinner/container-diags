# container-diags

* oc new-project foo
* oc new-app https://github.com/dbaker-rh/container-diags
* oc start-build container-diags --follow
* oc rsh $( oc get pods | awk '$1!~/-build/ && $3=="Running" {print $1}' ) bash
*

