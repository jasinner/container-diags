# container-diags

## Directly from this github repo

* oc login ...
* oc new-project foo
* oc new-app https://github.com/dbaker-rh/container-diags
* oc logs -f bc/container-diags # this waits for build to finish
* oc rsh $( oc get pods | awk '$1!~/-build/ && $3=="Running" {print $1; exit}' ) bash
*

Rebuild after a repo update

* oc start-build container-diags --follow
* oc rsh $( oc get pods | awk '$1!~/-build/ && $3=="Running" {print $1; exit}' ) bash
*


## From a local copy of the repo

Note that by default "oc new-app" will detect the name of the remote repo and use it.  Override with "--name=bar", if desired.

* git clone https://github.com/dbaker-rh/container-diags.git && cd ./container-diags
* ... edit, as needed, ...
* git commit -am 'needed changes'
* git push
* oc login ...
* oc new-project foo
* oc new-app .
* oc logs -f bc/container-diags
* oc rsh $( oc get pods | awk '$1!~/-build/ && $3=="Running" {print $1; exit}' ) bash
*


This will not work if you have 2-factor auth setup on Github. In that case, create a [Personal Access Token with no scope](https://developer.github.com/apps/building-oauth-apps/understanding-scopes-for-oauth-apps/)
You'll also need to add your Personal Access Token to the OpenShift project:

* oc secret new-basicauth user-at-github --username=dbacker-rh --prompt
Password:
secret/user-at-github

* oc secrets link builder user-at-github
* oc annotate secret/user-at-github \
    'build.openshift.io/source-secret-match-uri-1=https://github.com/dbaker-rh/container-diags.git'

## From a local directory

Note we have no .git/ directory at all to confuse things.

* mkdir /tmp/whatever && cd /tmp/whatever
* wget https://raw.githubusercontent.com/dbaker-rh/container-diags/master/Dockerfile
* ... edit, as needed, ...
* oc login ...
* oc new-project foo
* oc new-app . --name=bar
* oc start-build bar --from-file=Dockerfile --follow
* oc rsh $( oc get pods | awk '$1!~/-build/ && $3=="Running" {print $1; exit}' ) bash
*


