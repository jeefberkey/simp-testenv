# simp-testenv
Full stack SIMP test environment using Vagrant

## quick start

This is mainly a Vagrantfile, the SIMP vagrant box is not publicly available.

To bring up the puppetserver, simply run `vagrant up`. The `server` machine is default and will be acted on if you don't specify a machine.

There is also a client machine, which can be brought up with `vagrant up client` and acted upon with `vagrant <command> client`.

## Default Passwords

| account | password |
| ------: | -------- |
| root | RootPassword |
| simp | suP3rP@ssw0r!9371 |
| vagrant | vagrant |
| ldap::bind_pw | CU0%d%7xRYFJcI9yt7nr*0BUZ8IHg&eo |
| ldap::sync_pw | pwJORySZfSg+Ftwb9EmMRC&ql1f7PU*N |
| ldap::root_pw | NjUfdMTAKUMRdNNDXcfTVvrKJTgY8uZQ |
| grub::password | LlAZUYo5vb6mNmtgEzAGqs53k4s-*AbD |
