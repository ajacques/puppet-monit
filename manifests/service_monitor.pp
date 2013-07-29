define monit::service_monitor (
	$service_name   = undef,
	$pid_file       = undef,
	$start_path     = undef,
	$stop_path      = undef,
	$max_memory     = undef,
	$max_children   = undef,
	$max_restarts   = undef,
	$dependencies   = undef,
	$require        = undef
) {
	if ($service_name == undef) {
		fail('monit: Service name must be defined')
	}

	if ($pid_file == undef) {
		fail('monit: PID file must be defined')
	}

	$pid_path = $::operatingsystem ? {
		/(?i-mx:debian|ubuntu)/ => "/var/run/${pid_file}"
	}

	file { "${monit::config::servicestub_dir}/${service_name}":
		ensure => 'file',
		owner => 'root',
		group => 'root',
		mode => '0440',
		content => template('monit/service-monitor.erb'),
		notify => Class['monit::service'],
		require => $require
	}
}
