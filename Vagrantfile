# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "puppetlabs/debian-7.8-64-puppet"

  config.vm.synced_folder "./puppet", "/src/puppet"
  config.vm.synced_folder "./resources", "/src/resources"

  config.vm.provision "shell", :privileged => true, :inline => <<-SHELL
    apt-get update
    apt-get install -y git ruby
    /usr/bin/gem install r10k
  SHELL

  config.vm.provision "shell", :privileged => true, :inline => <<-R10K
    cp /src/puppet/Puppetfile .
    PUPPETFILE=Puppetfile \
    PUPPETFILE_DIR=/opt/puppetlabs/puppet/modules \
    /usr/local/bin/r10k puppetfile install || :
  R10K

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = 'puppet/manifests'
    puppet.options = "--verbose"
  end

  config.vm.provision "shell", :privileged => true, :inline => <<-DBSETUP
    su - postgres -c "psql < /src/resources/db/b3ak3rdb.sql"
  DBSETUP
end
