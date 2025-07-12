Vagrant.configure("2") do |config|
  config.vm.define "DB_VM" do |db|
    db.vm.box = "ubuntu/focal64"
    db.vm.hostname = "db-vm"
    db.vm.network "private_network", ip: "192.168.56.10"

    db.vm.provision "shell",
      path: "provisioning/db_vm.sh",
      env: {
        'DB_USER' => ENV['DB_USER'],
        'DB_PASS' => ENV['DB_PASS'],
        'DB_NAME' => ENV['DB_NAME']
      }
  end

  config.vm.define "APP_VM" do |app|
    app.vm.box = "ubuntu/focal64"
    app.vm.hostname = "app-vm"
    app.vm.network "private_network", ip: "192.168.56.20"
    app.vm.network "forwarded_port", guest: 8080, host: 8080

    app.vm.provision "shell",
      path: "provisioning/app_vm.sh",
      env: {
        'APP_USER' => 'petclinicapp',
        'DB_HOST' => ENV['DB_HOST'],
        'DB_PORT' => ENV['DB_PORT'],
        'DB_NAME' => ENV['DB_NAME'],
        'DB_USER' => ENV['DB_USER'],
        'DB_PASS' => ENV['DB_PASS']
      }
  end
end
