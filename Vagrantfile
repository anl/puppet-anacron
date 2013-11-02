VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64_vmware.box"
  unless ENV['NO_VAGRANT_APTGET']
    config.vm.provision :shell, :inline => '/usr/bin/apt-get update'
  end
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "vagrant"
    puppet.manifest_file = "vagrant.pp"
    puppet.module_path = "../"
  end
end
