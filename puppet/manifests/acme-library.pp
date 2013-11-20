class mysql-setup {
	class { '::mysql::server':
		root_password => 'toor',
		
		users => {
			'acme@localhost' => {
				ensure => present,
				password_hash => mysql_password('acme'),
			}
		},
		
		databases => {
			'acme-library' => {
				ensure => present,
			},
		},
		
		grants => {
			'acme@localhost/acme-library.*' => {
				ensure => present,
				options => ['GRANT'],
				privileges => ['SELECT', 'INSERT', 'UPDATE', 'DELETE'],
				table => 'acme-library.*',
				user => 'acme@localhost',
			}
		}
	}
	
	exec { 'mysql-import':
		require => Class['::mysql::server'],
		command => '/usr/bin/mysql -uroot -ptoor acme-library < /puppet/manifests/acme-library.sql',
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
		docroot => '/app',
		
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
		target => '/app/target/webapp',
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
	exec { 'app-compile':
		require => Package['maven2'],
		command => '/usr/bin/mvn compile',
		cwd => '/app',
	}
	
	exec { 'app-explode':
		require => Package['maven2'],
		command => '/usr/bin/mvn war:exploded',
		cwd => '/app',
	}
}

include mysql-setup
include apache-setup
include tomcat-setup
include maven-setup
include app-setup
