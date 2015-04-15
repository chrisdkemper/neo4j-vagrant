class neo4j {

    exec { 'Add neo4j key':
        command => 'wget -O - http://debian.neo4j.org/neotechnology.gpg.key | apt-key add -',
        unless  => 'apt-key list | grep admins@neotechnology.com'
    }

    exec { 'Add neo4j repository':
        command => 'echo "deb http://debian.neo4j.org/repo stable/" > /etc/apt/sources.list.d/neo4j.list',
        creates => '/etc/apt/sources.list.d/neo4j.list'
    }

    exec { 'Update repositories':
        command => '/usr/bin/apt-get update --fix-missing',
        require => [Exec['Add neo4j key'], Exec['Add neo4j repository']]
    }

    package { 'neo4j':
        ensure  => present,
        require => Exec['Update repositories']
    }

    service { 'neo4j-service':
        ensure  => running,
        require => Package['neo4j']
    }

    file { '/etc/neo4j/neo4j-server.properties':
        ensure  => present,
        owner   => 'neo4j',
        group   => 'adm',
        source  => 'puppet:///data/modules/neo4j/templates/neo4j-server.properties',
        require => Package['neo4j'],
        notify  => Service['neo4j-service']
    }

    file { '/var/lib/neo4j/data/dbms/auth':
        ensure  => present,
        owner   => 'neo4j',
        group   => 'nogroup',
        source  => 'puppet:///data/modules/neo4j/templates/auth',
        require => Package['neo4j'],
        notify  => Service['neo4j-service']
    }
}