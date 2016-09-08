#!/usr/bin/env bash

export GUID=8cb8

sed -i 's/search/search example.com/g' /etc/resolv.conf

echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

curl -o /root/oselab.ha.dns.installer.sh http://www.opentlc.com/download/ose_advanced/resources/3.1/oselab.ha.dns.installer.sh
chmod +x /root/oselab.ha.dns.installer.sh

wget http://idm.example.com/ipa/config/ca.crt -O /root/ipa-ca.crt

cat << EOF > /etc/yum.repos.d/open.repo
[rhel-x86_64-server-7]
name=Red Hat Enterprise Linux 7
baseurl=http://www.opentlc.com/repos/ose/3.2//rhel-7-server-rpms
enabled=1
gpgcheck=0

[rhel-x86_64-server-extras-7]
name=Red Hat Enterprise Linux 7 Extras
baseurl=http://www.opentlc.com/repos/ose/3.2//rhel-7-server-extras-rpms
enabled=1
gpgcheck=0

[rhel-x86_64-server-optional-7]
name=Red Hat Enterprise Linux 7 Optional
baseurl=http://www.opentlc.com/repos/ose/3.2//rhel-7-server-optional-rpms
enabled=1
gpgcheck=0

# This repo is added for the OPENTLC environment not OSE
[rhel-x86_64-server-rh-common-7]
name=Red Hat Enterprise Linux 7 Common
baseurl=http://www.opentlc.com/repos/ose/3.2//rhel-7-server-rh-common-rpms
enabled=1
gpgcheck=0

[rhel-7-server-ose-3.2-rpms]
name=Red Hat Enterprise Linux 7 OSE 3.2
baseurl=http://www.opentlc.com/repos/ose/3.2//rhel-7-server-ose-3.2-rpms
enabled=1
gpgcheck=0

EOF
