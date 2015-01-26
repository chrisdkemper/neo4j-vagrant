Vagrant.configure("2") do |config|

	config.vm.box = "trusty64"
	config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

	config.vm.hostname = "neo4j.vagrant.local"
	config.vm.network :forwarded_port, guest: 7474, host: 7474

	config.vm.provider :virtualbox do |virtualbox|
		virtualbox.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
		virtualbox.customize ["modifyvm", :id, "--memory", "1024"]
	end

	config.vm.provision :shell, :path => "env/provision.sh"
end
