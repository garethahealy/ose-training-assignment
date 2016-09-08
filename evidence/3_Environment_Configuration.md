3.Environment Configuration:



d.Aggregated logging is configured and working
e.Metrics Collection is configured and working

##
#a: Multitenancy is configured and working
os_sdn_network_plugin_name='redhat/openshift-ovs-multitenant'

[root@master1-8cb8 ~]# oc get netnamespaces
NAME               NETID
default            0
hello-world        13
management-infra   12
openshift          11
openshift-infra    10

##
#b: Node Selector is defined in the "default" Namespace
[root@master1-8cb8 ~]# oc get namespace default -o yaml
apiVersion: v1
kind: Namespace
metadata:
  annotations:
    openshift.io/node-selector: region=infra
    openshift.io/sa.initialized-roles: "true"
    openshift.io/sa.scc.mcs: s0:c1,c0
    openshift.io/sa.scc.supplemental-groups: 1000000000/10000
    openshift.io/sa.scc.uid-range: 1000000000/10000
  creationTimestamp: 2016-09-08T18:24:11Z
  name: default
  resourceVersion: "1412"
  selfLink: /api/v1/namespaces/default
  uid: 70854db6-75f1-11e6-81fc-2cc26003efa4
spec:
  finalizers:
  - kubernetes
  - openshift.io/origin
status:
  phase: Active

##
#c: Node Selector is defined in the "openshift-infra" and "logging" Projects
[root@master1-8cb8 ~]# oc get namespace openshift-infra -o yaml
apiVersion: v1
kind: Namespace
metadata:
annotations:
  openshift.io/node-selector: region=infra
  openshift.io/sa.initialized-roles: "true"
  openshift.io/sa.scc.mcs: s0:c3,c2
  openshift.io/sa.scc.supplemental-groups: 1000010000/10000
  openshift.io/sa.scc.uid-range: 1000010000/10000
creationTimestamp: 2016-09-08T18:24:16Z
name: openshift-infra
resourceVersion: "1418"
selfLink: /api/v1/namespaces/openshift-infra
uid: 732a55b9-75f1-11e6-81fc-2cc26003efa4
spec:
finalizers:
- kubernetes
- openshift.io/origin
status:
phase: Active


# deploy logging and metrics
