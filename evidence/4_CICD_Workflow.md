##
#a: Jenkins pod is running with Persistent Volume
See: screenshots/jenkins.png

[root@master1-8cb8 ~]# oc get pods
NAME              READY     STATUS    RESTARTS   AGE
jenkins-3-fbecb   1/1       Running   0          5m

[root@master1-8cb8 ~]# oc get pvc
NAME      STATUS    VOLUME        CAPACITY   ACCESSMODES   AGE
jenkins   Bound     pv01-volume   1Gi        RWO           20m

##
#b: Deploy openshift-tasks app using Jenkins
[root@master1-8cb8 ~]# oc project
Using project "openshift" on server "https://loadbalancer1.example.com:8443".

[root@master1-8cb8 ~]# oc get pods
NAME              READY     STATUS      RESTARTS   AGE
jenkins-3-fbecb   1/1       Running     0          36m
tasks-1-build     0/1       Completed   0          29m
tasks-1-ve29w     1/1       Running     0          11m

[root@master1-8cb8 ~]# curl -u 'redhat:redhat1!' -H "Accept: application/json" -X GET http://10.1.5.3:8080/ws/tasks/1
[{"id":1,"title":"task1","ownerName":"redhat"}]

##
#c: Create A CICD workflow Using Jenkins OpenShift Plugin
See screenshots/jenkins-cicd.png

##
#d: HPA configured and working on production deployment of openshift-tasks
[root@master1-8cb8 ~]# oc get hpa
NAME           REFERENCE                      TARGET    CURRENT   MINPODS   MAXPODS   AGE
tasks-scaler   DeploymentConfig/tasks/scale   5%        163%      2         10        43m



