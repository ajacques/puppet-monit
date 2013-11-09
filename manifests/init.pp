class monit {
	$installed = true

	package { 'monit':
		ensure => installed,
	}

	class {'monit::config':
		require => Package['monit'],
		notify => Exec['reload-monit']
	}

	class {'monit::service': 
		require => [
			Package['monit'],
			Class['monit::config']
		]
	}

	if defined(Class['logrotate::base']) {
		logrotate::rule {'logrotate-monit':
			name => 'monit',
			path => '/var/log/monit.log',
			rotate => 5,
			rotate_every => 'week',
			postrotate => '/etc/init.d/monit reload 2>&1 >/dev/null'
		}
	}
}
