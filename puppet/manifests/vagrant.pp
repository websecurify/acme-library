class system-update {
	class { 'apt':
	}
	
	exec { 'apt-update':
		command => '/usr/bin/apt-get update',
	}
	
	Exec['apt-update'] -> Package <| |>
}

class mysql-setup {
	class { 'mysql':
	}
	
	class { 'mysql::server':
		config_hash => {
			root_password => 'toor',
		},
	}
	
	mysql::db { 'acme-library':
		ensure => present,
		user => 'acme',
		password => 'acme',
		grant => ['all'],
		sql => '/vagrant/puppet/manifests/acme-library.sql',
		enforce_sql => true,
	}
}

class apache-setup {
	class { 'apache':
	}
	
	class { 'apache::mod::proxy_http':
	}
	
	apache::vhost { 'acme-library':
		default_vhost => true,
		port => '80',
		docroot => '/vagrant/app',
		
		proxy_pass => [
			{
				path => '/',
				url => 'http://localhost:8080/acme-library/',
			},
		],
	}
}

class tomcat-setup {
	package { 'tomcat7':
		ensure => installed,
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

class maven-setup {
	package { 'maven2':
		ensure => installed,
	}
}

class app-setup {
	exec { 'app-rebuild':
		require => Package['maven2'],
		command => '/usr/bin/mvn war:exploded',
		cwd => '/vagrant/app',
	}
}

include system-update
include mysql-setup
include apache-setup
include tomcat-setup
include maven-setup
include app-setup
