# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "puppetlabs/ubuntu-16.04-64-puppet"

  config.vm.network "private_network", ip: "192.168.33.15"

  config.vm.provision :puppet do |puppet|
    puppet.environment = "development"
    puppet.environment_path = "."
    puppet.working_directory = "/vagrant"
    puppet.hiera_config_path = "development/hiera.yml"
     puppet.facter = {
       "fqdn" => "192.168.33.15",
       "ipaddress" => "192.168.33.15"
     }
  end

end
