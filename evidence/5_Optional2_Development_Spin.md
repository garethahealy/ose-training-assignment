##
#a: Deploy ticket master or similar (multi pod) application.
See: screenshots/ticket-monster.png

[root@master1-8cb8 ~]# oc get pods | grep ticket-monster
ticket-monster-deploy-1-yr16q   1/1       Running            0          12m

##
#c: Create a Nexus Pod
See: screenshots/nexus.png

[root@master1-8cb8 ~]# oc get pod | grep nexus
nexus-1-xg861        1/1       Running            0          6m

[root@master1-8cb8 ~]# oc get pvc | grep nexus
nexus-pvc   Bound     pv04-volume   2Gi        RWO           6m

##
#d: Create a SonarQ Pod
See: screenshots/sonar.png

[root@master1-8cb8 ~]# oc get pods | grep sonar
sonarqube-3-lh4p6               1/1       Running            0          12m

[root@master1-8cb8 ~]# oc get pods | grep postgres
postgresql-1-yqhx8              1/1       Running            0          1h

##
#b: Create a Jenkins Workflow using "Jenkins Pipeline" and Jenkins-OpenShift Plugin
#e: Deploy using Jenkins in "dev" and make it pass all the unit tests
#f: Display Unit Test and Code Coverage results in Jenkins
#g: Deploy using Jenkins in "test" Pass an integration test to an AMQ or similarcomponent
#h: Display Integration tests results in Jenkins Console
#i: Artifacts should be stored and pulled in Nexus/Jenkins
Unable to complete these tasks, as nodes kept running out of memory to complete maven build.
