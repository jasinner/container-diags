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

Note that by default "oc new-app" will detect the name of the remote repo and use it.  Override with "--name=bar", if desired.  The first build will pull from the github repo, not your local copy, so you need to upload the Dockerfile and rebuild to incorporate any local edits.

* git clone https://github.com/dbaker-rh/container-diags.git && cd ./container-diags
* oc login ...
* oc new-project foo
* oc new-app .   # This builds based on the repo you cloned, not including any edits to the local directory
* oc logs -f bc/container-diags   # This waits for the build to finish

If you want to make local edits, such as adding extra packages, do so now.  This step uploads a copy of the local Dockerfile and rebuilds.

* ... edit, as needed, ...
* oc start-build container-diags --from-file=Dockerfile --follow   # Upload local edits and rebuild

Now, open a shell in the container we created.

* oc rsh $( oc get pods | awk '$1!~/-build/ && $3=="Running" {print $1; exit}' ) bash


### Additional notes on using GitHub repos

If you want to make more elaborate edits, or preserve the edits you make, then fork the repo on GitHub and push your edits there.

Private repos, or read-write operations over https will not work if you have 2FA enabled.

In that case, create a [Personal Access Token with no scope](https://developer.github.com/apps/building-oauth-apps/understanding-scopes-for-oauth-apps/)
You'll also need to add your Personal Access Token to the OpenShift project:

* oc secret new-basicauth user-at-github --username=dbaker-rh --prompt
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


