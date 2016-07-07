# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |c|
  server_post_up = <<EOS
Now run the following commands to get going:
  simp config -a /vagrant/simp_conf.yaml
  simp bootstrap

If you want to kickstart, run these commands:
  /usr/local/bin/unpack_dvd -d /var/www/yum /vagrant/CentOS-7-x86_64-DVD-1511.iso
  cd /etc/puppet/environments/simp/FakeCA
  echo client.test.net > togen
  ./gencerts_nopass.sh

When pxebooting, press ctrl+b and type `autoboot` net1 to boot off of the second interface
apache::conf::allowroot: "%{alias('client_nets')}"
EOS
  client_post_up = <<EOS
The root password is RootPassword, but you should be able to
log in with vagrant:vagrant.

Check and make sure you made your client certs.
EOS


  c.vm.define 'server', primary: true do |v|
    v.vm.hostname = 'puppet.test.net'
    v.vm.box = "simp-5.1.X-vagrant.box"
    v.vm.network "private_network",
      ip: "192.168.33.10",
      mac: "08002730d774",
      virtualbox__intnet: "test.net",
      virtualbox__dhcp_enabled: false
    v.ssh.username = 'vagrant'
    v.ssh.password = 'vagrant'
    v.vm.provider "virtualbox" do |vb|
      vb.memory = "3072"
      vb.cpus = "2"
    end
    v.vm.post_up_message = server_post_up
  end

  c.vm.define 'client', autostart: false do |v|
    v.vm.box = "simp-5.1.X-client-vagrant.box"
    v.vm.hostname = "client.test.net"
    v.vm.network "forwarded_port", guest: 80, host: 8080
    v.vm.network "private_network",
      mac: "080027555555",
      virtualbox__intnet: "test.net",
      virtualbox__dhcp_enabled: false,
      adapter: 2
    v.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = "2"
      vb.gui = "true"
      vb.customize [ "modifyvm", :id, "--boot1", "disk"]
      vb.customize [ "modifyvm", :id, "--boot2", "net"]
    end
    v.vm.post_up_message = client_post_up
  end
end
