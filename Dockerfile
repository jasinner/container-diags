FROM registry.centos.org/centos:7
MAINTAINER Dave Baker <dbaker@redhat.com>

# Quick-start:
#   oc new-project centos-nmap
#   oc new-app . --name=nmap
#   oc start-build nmap --from-file=Dockerfile --follow
#
# Base on centos image (this is pulled from docker hub; update to fedora:latest if you wish)
# Update, install epel and various sets of tools, create a non-root user, and sleep for an
# arbitrarily long time, waiting for you to connect manually.
#   oc get pods             # look for the pod that's Running ...
#   oc rsh $( oc get pods | awk '$1!~/-build/ && $3=="Running" {print $1; exit}' ) bash
# 

RUN set -x && \
    ( if [ -e /etc/os-release ]; then cat /etc/os-release; fi ) && \
    yum -y update && \
    yum install -y epel-release && \
    yum install -y net-tools iproute && \
    yum install -y nmap nmap-ncat socat telnet openssh-clients wget jq && \
    yum install -y gcc && \
    yum clean all && \
    rm -rf /var/cache/yum


RUN useradd user
USER user

# This container just sleeps.  Use "oc rsh" to connect to the running container to use it
CMD /usr/bin/sleep 31d


