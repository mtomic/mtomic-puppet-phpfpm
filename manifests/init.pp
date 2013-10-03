class phpfpm {
	exec { "add_php5_4":
		command => "add-apt-repository ppa:ondrej/php5; apt-get update;",
		path    => "/usr/bin/",
		refreshonly => true,
	}
	package { 'php5-fpm':
		ensure => present,
	}
	package { 'php-pear':
		ensure => present,
	}
	package { 'php5-user-cache':
		ensure => present,
	}
	package { 'php5-cgi':
		ensure => present,
	}
	package { 'php5-curl':
		ensure => present,
	}
	package { 'php5-mysql':
		ensure => present,
	}
	package { 'php5-gd':
		ensure => present,
	}
	package { 'php-apc':
		ensure => present,
	}
	package { 'php5-mcrypt':
		ensure => present,
	}
	package { 'php5-cli':
		ensure => present,
	}
#	file { '/etc/php5/conf.d/apc.ini':
#		ensure  => file,
#		mode    => 644,
#		source  => 'puppet:///modules/phpfpm/apc.ini',
#		require => Package['php-apc'],
#	}
#	file { '/etc/php5/cli/conf.d/apc.ini':
#               ensure  => file,
#               mode    => 644,
#                source  => 'puppet:///modules/phpfpm/apc.ini',
#                require => Package['php-apc'],
#        }
	service { 'php5-fpm':
		ensure => running,
		enable => true,
	}
}
