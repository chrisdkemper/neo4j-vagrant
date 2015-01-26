class neo4j {

    exec { 'Add neo4j key':
        command => 'wget -O - http://debian.neo4j.org/neotechnology.gpg.key | apt-key add -'
    }
    
    exec { 'Add neo4j repository':
        command => "echo 'deb http://debian.neo4j.org/repo stable/' > /etc/apt/sources.list.d/neo4j.list"    
    }
    
    exec { 'Update repositories':
        command => '/usr/bin/apt-get update --fix-missing',
        require => [Exec['Add neo4j key'], Exec['Add neo4j repository']]
    }
    
    package { 'neo4j':
        ensure => present,
        require => Exec['Update repositories']
    }
    
    service { 'neo4j-service':
        ensure => running,
        require => Package['neo4j']
    }
    
    file { '/etc/neo4j/neo4j-server.properties':
        ensure => present,
        owner => 'root',
        group => 'root',
        source => 'puppet:///data/modules/neo4j/templates/neo4j-server.properties',
        require => Package['neo4j'],
        notify => Service['neo4j-service']
    }
}