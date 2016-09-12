# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |c|
  server_post_up = <<-EOS.gsub(/^[[:blank:]]{4}/, '')
    Now run the following commands to get going:

        simp config -a /vagrant/answers.yaml
        simp bootstrap
        ldapadd -Z -x -D 'cn=LDAPAdmin,ou=People,dc=simp,dc=test' -w 'NjUfdMTAKUMRdNNDXcfTVvrKJTgY8uZQ' -f /var/local/simp/files/add_user_with_password.ldif

    You may way to run puppet an addtional few more times: `puppet agent -t`

    If you want to kickstart, run these commands:

        /usr/local/bin/unpack_dvd -d /var/www/yum /vagrant/CentOS-7-x86_64-DVD-1511.iso
        cd /etc/puppet/environments/simp/FakeCA
        echo client01.simp.test > togen
        ./gencerts_nopass.sh

    When pxebooting, press ctrl+b and type `autoboot` net1 to boot off of the second interface
  EOS

  client_post_up = <<-EOS.gsub(/^[[:blank:]]{4}/, '')
    The root password is RootPassword, but you should be able to
    log in with vagrant:vagrant.

    Check and make sure you made your client certs.
  EOS

  c.vm.define 'server01', primary: true do |v|
    v.vm.box      = 'SIMP-5.1.X-CentOS-7-DVD-1511'
    v.vm.hostname = 'server01.simp.test'
    v.vm.network 'private_network',
                 ip: '192.168.33.10',
                 mac: '08002730d774',
                 virtualbox__intnet: 'test',
                 virtualbox__dhcp_enabled: false
    v.vm.provider 'virtualbox' do |vb|
      vb.memory = '3072'
      vb.cpus   = '2'
    end
    v.vm.post_up_message = server_post_up

    # Once LDAP is set up, you should comment out the next 2 lines
    v.ssh.username         = 'vagrant'
    v.ssh.password         = 'vagrant'
    v.ssh.private_key_path = 'simp-vagrant-id_rsa'
    v.ssh.insert_key       = false
  end

  c.vm.define 'client01', autostart: false do |v|
    v.vm.box      = 'pxe-client'
    v.vm.hostname = 'client01.simp.test'
    v.vm.network 'forwarded_port', guest: 80, host: 8080
    v.vm.network 'private_network',
                 mac: '080027555555',
                 virtualbox__intnet: 'test',
                 virtualbox__dhcp_enabled: false,
                 adapter: 2
    v.vm.provider 'virtualbox' do |vb|
      vb.memory = '1024'
      vb.cpus   = '2'
      vb.customize ['modifyvm', :id, '--nicbootprio1', '0']
      vb.customize ['modifyvm', :id, '--nicbootprio2', '1']
      vb.customize ['modifyvm', :id, '--boot1', 'disk']
      vb.customize ['modifyvm', :id, '--boot2', 'net']
    end
    v.vm.post_up_message = client_post_up
    v.vm.boot_timeout    = 1260
    v.vm.synced_folder '.', '/vagrant', disabled: true

    # The username and password are only needed for pre-bootstrap operations.
    v.ssh.username         = 'vagrant'
    v.ssh.password         = 'vagrant'
    v.ssh.private_key_path = 'simp-vagrant-id_rsa'
    v.ssh.insert_key       = false
  end
end
