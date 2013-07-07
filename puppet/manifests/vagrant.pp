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

  class { 'mysql::java':
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

  apache::vhost { 'acme-library':
    port => '80',
    docroot => '/vagrant/www',
	default_vhost => true,
  }
}

include system-update
include mysql-setup
include apache-setup
