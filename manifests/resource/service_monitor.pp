# define: monit::resource::service_monitor
define monit::resource::service_monitor (
	$service_name		= undef,
	$pid_file			= undef,
	$start_path			= nil,
	$stop_path			= nil,
	$max_memory			= nil,
	$max_children		= nil,
	$max_restarts 		= nil,
	$require		= undef
)
{
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
		content => template('monit/service-monitor.erb'),
		notify => Class['monit::service'],
		require => $require
	}
}
