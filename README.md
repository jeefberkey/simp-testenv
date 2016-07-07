# simp-testenv
Full stack SIMP test environment using Vagrant

## quick start

This is mainly a Vagrantfile, the SIMP vagrant box is not publicly available.

To bring up the puppetserver, simply run `vagrant up`. The `server` machine is default and will be acted on if you don't specify a machine.

There is also a client machine, which can be brought up with `vagrant up client` and acted upon with `vagrant <command> client`.
