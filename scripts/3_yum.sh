#!/usr/bin/env bash

for node in master1 master2 master3 infranode1 infranode2 node1 node2 node3 node4 node5 node6
do
  echo Configing YUM and other pre-reqs $node ;

  scp /etc/yum.repos.d/open.repo ${node}.example.com:/etc/yum.repos.d/open.repo ;

  ssh ${node}.example.com "yum clean all; yum repolist" ;
  ssh ${node}.example.com "yum update -y" ;

  ssh ${node}.example.com "systemctl restart docker" ;

  ssh ${node}.example.com "yum install -y NetworkManager" ;
  ssh ${node}.example.com "systemctl restart NetworkManager" ;
done
