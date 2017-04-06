# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network "private_network", ip: "192.168.33.15"

  # r10k plugin to deploy puppet modules
  config.r10k.puppet_dir = "provision"
  config.r10k.puppetfile_path = "provision/Puppetfile"
  config.r10k.module_path = "provision/vendor-modules"

  config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "provision/manifests"
     puppet.manifest_file  = "init.pp"
     puppet.module_path = ["provision/vendor-modules", "provision/private-modules"]
     puppet.facter = {
       "fqdn" => "192.168.33.15",
       "ipaddress" => "192.168.33.15"
     }
  end

    config.vm.provision "shell", inline: "ip route replace 192.168.0.1 dev eth0"
end
