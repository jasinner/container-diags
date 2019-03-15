# container-diags

## Directly from this github repo

* oc login ...
* oc new-project foo
* oc new-app https://github.com/dbaker-rh/container-diags
* oc logs -f bc/container-diags # wait for build to finish
* oc rsh $( oc get pods | awk '$1!~/-build/ && $3=="Running" {print $1}' ) bash
*

## From a local copy of the repo

Note that by default "oc new-app" will detect the name of the remote repo and use it.  Override with "--name=bar", if desired.

* git clone https://github.com/dbaker-rh/container-diags.git && cd ./container-diags
* ... edit, as needed, ...
* oc login ...
* oc new-project foo
* oc new-app .
* oc start-build container-diags --from-file=Dockerfile --follow
* oc rsh $( oc get pods | awk '$1!~/-build/ && $3=="Running" {print $1}' ) bash
*


## From a local directory

Note we have no .git/ directory at all to confuse things.

* mkdir /tmp/whatever && cd /tmp/whatever
* wget https://raw.githubusercontent.com/dbaker-rh/container-diags/master/Dockerfile
* ... edit, as needed, ...
* oc login ...
* oc new-project foo
* oc new-app . --name=bar
* oc start-build bar --from-file=Dockerfile --follow
* oc rsh $( oc get pods | awk '$1!~/-build/ && $3=="Running" {print $1}' ) bash
*


