class monit (
	$notify_emails = $::monit_notify_emails,
	$notify_server = $::monit_notify_server
) {
	$installed = true

	package { 'monit':
		ensure => installed,
	}

	class {'monit::config':
		notify_emails => $notify_emails,
		notify_server => $notify_server,
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
			ensure => present,
			name => 'monit',
			path => '/var/log/monit.log',
			rotate => '5',
			rotate_every => 'week',
			postrotate => '/etc/init.d/monit reload 2>&1 >/dev/null'
		}
	}
}
