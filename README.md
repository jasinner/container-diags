# container-diags

## From github repo
* oc new-project foo
* oc new-app https://github.com/dbaker-rh/container-diags
* oc logs -f bc/container-diags # wait for build to finish
* oc rsh $( oc get pods | awk '$1!~/-build/ && $3=="Running" {print $1}' ) bash
*

## From a local directory (without .git present)
* oc new-project foo
* oc new-app . --name=bar
* oc start-build bar --from-file=Dockerfile --follow
* oc rsh $( oc get pods | awk '$1!~/-build/ && $3=="Running" {print $1}' ) bash
*

