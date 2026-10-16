Vagrant.configure("2") do |config|
config.vm.box = "debian/bookworm64"
config.vm.hostname = "debian"
config.vm.network "private_network", ip: "192.168.56-10"
config.vm.provider "virtualbox" do |vb|
vb.memory = 1024
vb.cpus = 1
end
end
