1.Basic Requirements:
a.Can authenticate at the master console
b.Registry has Storage attached and working
c.Router is configured on each Infranodes
d.Different PVs are available for users to consume
e.Can deploy a simple app1

2.HA Deployment:
a.There are 3 Masters Working
b.There are 3 EtcD Instances working
c.There is Loadbalancer to access the Masters
d.There is a Load Balancer/DNS for both Infranodes
e.There are at least 2 Infranodes

3.Environment Configuration:
a.Multitenancy is configured and working
b.Node Selector is defined in the "default" Namespace
c.Node Selector is defined in the "openshift-infra" and "logging" Projects
d.Aggregated logging is configured and working
e.Metrics Collection is configured and working

4.CICD Workflow
a.Jenkins pod is running with Persistent Volume
b.Deploy openshift-tasks app using Jenkins
c.Create A CICD workflow Using Jenkins OpenShift Plugin
d.HPA configured and working on production deployment of openshift-tasks

Optional Component 2 - Development spin
a.Deploy ticket master or similar (multi pod) application.
b.Create a Jenkins Workflow using "Jenkins Pipeline" and Jenkins-OpenShift Plugin
c.Create a Nexus Pod
d.Create a SonarQ Pod
e.Deploy using Jenkins in "dev" and make it pass all the unit tests
f.Display Unit Test and Code Coverage results in Jenkins
g.Deploy using Jenkins in "test" Pass an integration test to an AMQ or similarcomponent
h.Display Integration tests results in Jenkins Console
i.Artifacts should be stored and pulled in Nexus/Jenkins
