#a: Can authenticate at the master console
See screenshots/user1-logged-in.png

##
#b: Registry has Storage attached and working
[root@master1-8cb8 ~]# oc get pods | grep registry
docker-registry-2-7q3x6   1/1       Running   0          7m
docker-registry-2-ie4cm   1/1       Running   0          8m

[root@master1-8cb8 ~]# oc get pv | grep registry
NAME              CAPACITY   ACCESSMODES   STATUS    CLAIM                    REASON    AGE
registry-volume   5Gi        RWX           Bound     default/registry-claim             32m

[root@master1-8cb8 ~]# oc get pvc
NAME             STATUS    VOLUME            CAPACITY   ACCESSMODES   AGE
registry-claim   Bound     registry-volume   5Gi        RWX           32m

##
#c: Router is configured on each Infranodes
[root@master1-8cb8 ~]# oc get pods -o wide
NAME                      READY     STATUS    RESTARTS   AGE       NODE
docker-registry-2-7q3x6   1/1       Running   0          3m        infranode2.example.com
docker-registry-2-ie4cm   1/1       Running   0          4m        infranode1.example.com
router-1-vr10v            1/1       Running   0          5m        infranode2.example.com
router-1-zs9ba            1/1       Running   0          1m        infranode1.example.com

##
#d: Different PVs are available for users to consume
[root@oselab-8cb8 nfs]# pwd
/srv/nfs

[root@oselab-8cb8 nfs]# ll
total 0
drwxrwxrwx. 2 nfsnobody nfsnobody 6 Sep  8 15:06 pv01
drwxrwxrwx. 2 nfsnobody nfsnobody 6 Sep  8 15:06 pv02
drwxrwxrwx. 2 nfsnobody nfsnobody 6 Sep  8 15:06 pv03
drwxrwxrwx. 2 nfsnobody nfsnobody 6 Sep  8 15:06 pv04
drwxrwxrwx. 2 nfsnobody nfsnobody 6 Sep  8 14:17 registry

[root@master1-8cb8 ~]# oc get pv
NAME              CAPACITY   ACCESSMODES   STATUS      CLAIM                    REASON    AGE
pv01-volume       1Gi        RWO           Available                                      55s
pv02-volume       1Gi        RWO           Available                                      30s
pv03-volume       1Gi        RWO           Available                                      17s
pv04-volume       1Gi        RWO           Available                                      4s
registry-volume   5Gi        RWX           Bound       default/registry-claim             38m

##
#e: Can deploy a simple app1
[root@master1-8cb8 ~]# oc project
Using project "hello-world" on server "https://loadbalancer1.example.com:8443".

[root@master1-8cb8 ~]# oc get pods
NAME              READY     STATUS    RESTARTS   AGE
hello-openshift   1/1       Running   0          1m

[root@master1-8cb8 ~]# oc get pod hello-openshift -o yaml | grep podIP
  podIP: 10.1.10.2
  
[root@master1-8cb8 ~]# curl 10.1.10.2:8080
Hello OpenShift!
