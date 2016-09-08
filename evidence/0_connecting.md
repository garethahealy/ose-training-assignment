root password: r3dh4t1\!

# Connect to JUMP BOX
export GUID=8cb8
ssh -i ~/.ssh/opentlc gahealy-redhat.com@oselab-$GUID.oslab.opentlc.com

# Check status of OSE env
## Check Docker is OK
for node in master1 master2 master3 infranode1 infranode2 node1 node2 node3 node4 node5 node6
do
    ssh $node.example.com "echo docker $node.example.com && systemctl status docker"
done

## Check OSE is OK
for node in master1 master2 master3 node1 node2 node3 node4 node5 node6 infranode1 infranode2
do
    sudo ssh $node.example.com "echo ose $node.example.com && systemctl status atomic-openshift-node.service"
done


## Logins
U: user1
P: openshift
https://loadbalancer1-8cb8.oslab.opentlc.com:8443


oc get pods --all-namespaces








