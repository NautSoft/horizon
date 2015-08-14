Vagrant.configure("2") do |config|
	config.vm.box = "precise64"
	config.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 2
    end
	config.vm.synced_folder "srv/", "/srv/"
	config.vm.synced_folder "./", "/aws_api_lambda_local/"
	config.vm.synced_folder "~/.aws/", "/aws_creds/"
	config.vm.provision :salt do |salt|
		salt.minion_config = "srv/minion"
		salt.run_highstate = true
	end
end

Vagrant::Config.run do |config|
    config.vm.forward_port 3000, 3100
	config.vm.forward_port 8000, 8000
	config.vm.forward_port 8080, 8080
	config.vm.forward_port 5858, 5858
	config.vm.forward_port 5959, 5959
end
