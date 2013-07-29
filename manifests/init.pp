class monit {
	$installed = true

	package { 'monit':
		ensure => installed,
	}

	class {'monit::config':
		require => Package['monit'],
		notify => Service['monit']
	}

	class {'monit::service': 
		require => [
			Package['monit'],
			Class['monit::config']
		]
	}
}
