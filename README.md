# container-diags

* oc new-project foo
* oc new-app https://github.com/dbaker-rh/container-diags
* oc logs -f bc/container-diags # wait for build to finish
* oc rsh $( oc get pods | awk '$1!~/-build/ && $3=="Running" {print $1}' ) bash
*

