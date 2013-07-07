class system-update {
  class { 'apt':
  }

  exec { 'apt-update':
    command => '/usr/bin/apt-get update',
  }

  Exec['apt-update'] -> Package <| |>
}

class mysql-setup {
  require system-update

  class { 'mysql':
  }

  class { 'mysql::server':
    config_hash => {
      root_password => 'toor'
    },
  }
}

class apache-setup {
  require system-update

  class { 'apache':
    mpm_module => 'prefork',
  }

  class { 'apache::mod::proxy_http':
  }

  apache::vhost { 'acme-library':
    port => '80',
    docroot => '/vagrant/app',
	proxy_pass => [ { path => '/', url => 'http://localhost:8080/acme-library/' } ],
	default_vhost => true,
  }
}

class tomcat-setup {
  require system-update

  package { 'tomcat7':
    ensure => installed
  }

  file { '/var/lib/tomcat7/webapps/acme-library':
    require => Package['tomcat7'],

    ensure => link,
	target => '/vagrant/app/target/webapp',
  }

  service { 'tomcat7':
    require => Package['tomcat7'],

    ensure => running,
  }
}

include system-update
include mysql-setup
include apache-setup
include tomcat-setup
