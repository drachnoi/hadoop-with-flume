# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "forwarded_port", guest: 8088, host: 8088
  config.vm.network "forwarded_port", guest: 8042, host: 8042
  config.vm.network "forwarded_port", guest: 9000, host: 9000
  config.vm.network "forwarded_port", guest: 50070, host: 50070

  # r10k plugin to deploy puppet modules
  config.r10k.puppet_dir = "provision"
  config.r10k.puppetfile_path = "provision/Puppetfile"
  config.r10k.module_path = "provision/vendor-modules"

  config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "provision/manifests"
     puppet.manifest_file  = "init.pp"
     puppet.module_path = ["provision/vendor-modules", "provision/private-modules"]
  end
end
