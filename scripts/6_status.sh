#!/usr/bin/env bash

for node in master1 master2 master3 infranode1 infranode2 node1 node2 node3 node4 node5 node6
do
  ssh ${node}.example.com "systemctl status docker" ;
  ssh ${node}.example.com "systemctl status NetworkManager" ;
done
