# Class: php5-fpm
#
#   This module adds the latest stable PHP version (v5.5) to the target node.
#
#
class php5-fpm {
	case $::osfamily {
	    'Debian': {
	      $add_repo_cmd     = '/usr/bin/add-apt-repository -y ppa:ondrej/php5'
	      $update_repos_cmd = '/usr/bin/apt-get update -y -qq'
	
	      exec { 'add_php_repo':
	        command => $add_repo_cmd,
	        notify  => Exec['update_php_repos'],
	        unless  => '/usr/bin/test -f /etc/apt/sources.list.d/ondrej-php5-trusty.list'
	      }
	      exec { 'update_php_repos':
	        command     => $update_repos_cmd,
	        require     => Exec['add_php_repo'],
	        before      => Package['php5-fpm'],
	        refreshonly => true,
	      }
	    }
	
	    default: {
	      fail("The php5-fpm module does not support ${::osfamily}.")
	    }
	}

	package { 'php5-fpm':
                ensure => present,
                require => Exec['add_php_repo'],
        }

	package { 'php5-curl':
		ensure => present,
		require => Exec['add_php_repo'],
	}
	package { 'php5-mysql':
		ensure => present,
		require => Exec['add_php_repo'],
	}
	package { 'php5-gd':
		ensure => present,
		require => Exec['add_php_repo'],
	}
	package { 'php5-mcrypt':
		ensure => present,
		require => Exec['add_php_repo'],
	}
	package { 'php5-cli':
		ensure => present,
		require => Exec['add_php_repo'],
	}
	service { 'php5-fpm':
		ensure => running,
		enable => true,
		require => Package['php5-curl','php5-mysql','php5-gd','php5-mcrypt','php5-cli'],
	}
}
