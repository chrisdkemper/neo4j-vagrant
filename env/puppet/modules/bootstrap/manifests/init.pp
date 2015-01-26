class bootstrap {

    group { 'puppet':
        ensure => 'present',
        require => Exec['apt-get update']
    }
    
    exec { 'locale-gen en_GB.UTF-8':
        command => 'locale-gen en_GB.UTF-8',
        require => Exec['apt-get update']
    }
    
    exec { 'set home directory':
        command => 'echo "if [ -d /vagrant ]; then cd /vagrant; fi" >> /home/vagrant/.bashrc'
    }
    
    exec { 'create swap':
        command => 'fallocate -l 2G /swapfile'
    }
    
    exec { 'chmod swap':
        command => 'chmod 600 /swapfile',
        require => Exec['create swap']
    }
    
    exec { 'setup swap':
        command => 'mkswap /swapfile',
        require => Exec['chmod swap']
    }
    
    exec { 'enable swap':
        command => 'swapon /swapfile',
        require => Exec['setup swap']
    }
}