#!/bin/bash

/usr/local/bin/unpack_dvd -d /var/www/yum /vagrant/CentOS-7-x86_64-DVD-1511.iso
cd /etc/puppet/environments/simp/FakeCA
echo client.test.net > togen
./gencerts_nopass.sh

