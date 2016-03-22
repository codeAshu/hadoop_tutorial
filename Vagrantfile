# -*- mode: ruby -*-
# vi: set ft=ruby :


# Configuration parameters
boxRam = 4096                      # Ram in MB
boxCpus = 2                        # Number of CPU core


Vagrant.configure(2) do |config|
  config.vm.define "hadoopvm64" do |master|
    master.vm.box = "https://atlas.hashicorp.com/webysther/boxes/gitlab-ce-ubuntu-x64-14.04/versions/1.0/providers/virtualbox.box"
    master.vm.provider :virtualbox do |v|
      v.name = master.vm.hostname.to_s
      v.customize ["modifyvm", :id, "--memory", "#{boxRam}"]
      v.customize ["modifyvm", :id, "--cpus", "#{boxCpus}"]
    end
    master.vm.network :private_network, ip: "10.211.55.101"
    master.vm.hostname = "10.211.55.101"
    master.vm.provision "shell", path: "scripts/common.sh"
    master.vm.provision "shell", path: "scripts/setup-ubuntu.sh"
    master.vm.provision "shell", path: "scripts/setup-java.sh"
  end
end
