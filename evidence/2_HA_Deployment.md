##
#a: There are 3 Masters Working / e: There are at least 2 Infranodes
[root@master1-8cb8 ~]# oc get nodes --show-labels
NAME                             STATUS                     AGE       LABELS
infranode1.example.com           Ready                      16m       kubernetes.io/hostname=infranode1.example.com,region=infra,zone=tlc
infranode2.example.com           Ready                      16m       kubernetes.io/hostname=infranode2.example.com,region=infra,zone=tlc
master1-8cb8.oslab.opentlc.com   Ready,SchedulingDisabled   16m       kubernetes.io/hostname=master1-8cb8.oslab.opentlc.com
master2-8cb8.oslab.opentlc.com   Ready,SchedulingDisabled   16m       kubernetes.io/hostname=master2-8cb8.oslab.opentlc.com
master3-8cb8.oslab.opentlc.com   Ready,SchedulingDisabled   16m       kubernetes.io/hostname=master3-8cb8.oslab.opentlc.com
node1-8cb8.oslab.opentlc.com     Ready                      16m       kubernetes.io/hostname=node1-8cb8.oslab.opentlc.com,region=primary,zone=tlc
node2-8cb8.oslab.opentlc.com     Ready                      16m       kubernetes.io/hostname=node2-8cb8.oslab.opentlc.com,region=primary,zone=tlc
node3-8cb8.oslab.opentlc.com     Ready                      16m       kubernetes.io/hostname=node3-8cb8.oslab.opentlc.com,region=primary,zone=tlc
node4-8cb8.oslab.opentlc.com     Ready                      16m       kubernetes.io/hostname=node4-8cb8.oslab.opentlc.com,region=primary,zone=tlc
node5-8cb8.oslab.opentlc.com     Ready                      16m       kubernetes.io/hostname=node5-8cb8.oslab.opentlc.com,region=primary,zone=tlc
node6-8cb8.oslab.opentlc.com     Ready                      16m       kubernetes.io/hostname=node6-8cb8.oslab.opentlc.com,region=primary,zone=tlc

[masters]
master1.example.com
master2.example.com
master3.example.com

##
#b: There are 3 EtcD Instances working
[etcd]
master1.example.com
master2.example.com
master3.example.com
