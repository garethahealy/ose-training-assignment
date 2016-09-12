##
#a: Multitenancy is configured and working - /etc/ansible/hosts extract:
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

##
#d: Aggregated logging is configured and working
[root@master1-8cb8 ~]# oc project
Using project "logging" on server "https://loadbalancer1.example.com:8443".

[root@master1-8cb8 ~]# oc get pods
NAME                          READY     STATUS      RESTARTS   AGE
logging-deployer-mzb64        0/1       Completed   0          1h
logging-es-hnwvhnk6-3-rltjd   1/1       Running     0          19m
logging-fluentd-1-aluhw       1/1       Running     0          17m
logging-fluentd-1-ank91       1/1       Running     0          17m
logging-fluentd-1-gou42       1/1       Running     0          17m
logging-fluentd-1-ol4f5       1/1       Running     0          17m
logging-fluentd-1-xlkm0       1/1       Running     0          17m
logging-fluentd-1-ygxl6       1/1       Running     0          17m
logging-kibana-1-eyu84        2/2       Running     4          52m

[root@master1-8cb8 ~]# oc get pvc
NAME                    STATUS    VOLUME        CAPACITY   ACCESSMODES   AGE
elasticsearch-storage   Bound     pv03-volume   1Gi        RWO           20m

##
#e: Metrics Collection is configured and working
See: screenshots/metrics.png

[root@master1-8cb8 ~]# oc project
Using project "openshift-infra" on server "https://loadbalancer1.example.com:8443".

[root@master1-8cb8 ~]# oc get pods -o wide
NAME                         READY     STATUS      RESTARTS   AGE       NODE
hawkular-cassandra-1-opss4   1/1       Running     0          3d        infranode1.example.com
hawkular-metrics-rtvcc       1/1       Running     1          3d        infranode2.example.com
heapster-7a0dw               1/1       Running     1          3d        infranode2.example.com
metrics-deployer-looll       0/1       Completed   0          3d        infranode1.example.com
