#!/usr/bin/env bash

yum install -y atomic-openshift-utils

sed -i 's/timeout = 10/timeout = 30/g' /etc/ansible/ansible.cfg

cat << EOF > /etc/ansible/hosts
[OSEv3:children]
masters
nodes
etcd
lb
nfs

# Set variables common for all OSEv3 hosts
[OSEv3:vars]
ansible_ssh_user=root
deployment_type=openshift-enterprise

# LDAP auth
openshift_master_identity_providers=[{'name': 'idm', 'challenge': 'true', 'login': 'true', 'kind': 'LDAPPasswordIdentityProvider', 'attributes': {'id': ['dn'], 'email': ['mail'], 'name': ['cn'], 'preferredUsername': ['uid']}, 'bindDN': 'uid=admin,cn=users,cn=accounts,dc=example,dc=com', 'bindPassword': 'r3dh4t1!', 'ca': '/etc/origin/master/ipa-ca.crt', 'insecure': 'false', 'url': 'ldap://idm.example.com/cn=users,cn=accounts,dc=example,dc=com?uid?sub?(memberOf=cn=ose-user,cn=groups,cn=accounts,dc=example,dc=com)'}]
openshift_master_ldap_ca_file=/root/ipa-ca.crt

# Native high availability cluster method with optional load balancer.
# If no lb group is defined installer assumes that a load balancer has
# been preconfigured. For installation the value of
# openshift_master_cluster_hostname must resolve to the load balancer
# or to one or all of the masters defined in the inventory if no load
# balancer is present.
openshift_master_cluster_method=native
openshift_master_cluster_hostname=loadbalancer1.example.com
openshift_master_cluster_public_hostname=loadbalancer1-$GUID.oslab.opentlc.com

# default subdomain to use for exposed routes
openshift_master_default_subdomain=cloudapps-$GUID.oslab.opentlc.com

# Configure metricsPublicURL in the master config for cluster metrics
# See: https://docs.openshift.com/enterprise/latest/install_config/cluster_metrics.html
openshift_master_metrics_public_url=https://metrics.cloudapps-$guid.oslab.opentlc.com

# Enable cockpit
osm_use_cockpit=false

# default project node selector
osm_default_node_selector='region=primary'
openshift_hosted_router_selector='region=infra'
openshift_hosted_router_replicas=2
openshift_hosted_router_certificate={"certfile": "/root/certs/router.crt", "keyfile": "/root/certs/router.key", "cafile": "/root/certs/router-ca.crt"}
openshift_hosted_registry_selector='region=infra'
openshift_hosted_registry_replicas=2

openshift_hosted_registry_storage_kind=nfs
openshift_hosted_registry_storage_access_modes=['ReadWriteMany']
openshift_hosted_registry_storage_host=oselab.example.com
openshift_hosted_registry_storage_nfs_directory=/srv/nfs
openshift_hosted_registry_storage_volume_name=registry
openshift_hosted_registry_storage_volume_size=5Gi

# Multitenancy plugin
os_sdn_network_plugin_name='redhat/openshift-ovs-multitenant'

# Force setting of system hostname when configuring OpenShift
# This works around issues related to installations that do not have valid dns
# entries for the interfaces attached to the host.
openshift_set_hostname=True

[nfs]
oselab.example.com

# host group for masters
[masters]
master1.example.com
master2.example.com
master3.example.com

# host group for etcd
[etcd]
master1.example.com
master2.example.com
master3.example.com

# Specify load balancer host
[lb]
loadbalancer1.example.com

# host group for nodes, includes region info
[nodes]
master[1:3].example.com
infranode1.example.com openshift_node_labels="{'region': 'infra', 'zone': 'tlc'}" openshift_hostname=infranode1.example.com
infranode2.example.com openshift_node_labels="{'region': 'infra', 'zone': 'tlc'}" openshift_hostname=infranode2.example.com
node[1:3].example.com openshift_node_labels="{'region': 'primary', 'zone': 'tlc'}"
node[4:6].example.com openshift_node_labels="{'region': 'primary', 'zone': 'tlc'}"

EOF


