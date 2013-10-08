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
}
