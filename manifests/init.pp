class monit inherits monit::config {
	$installed = true

	package { 'monit':
		ensure => installed,
	}

	class { 'monit::service': 
	}
}
