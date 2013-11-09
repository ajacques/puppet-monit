class monit::service {
	exec { 'reload-monit':
		command => "${monit::config::exe_path} reload",
		refreshonly => true,
	}
	service { 'monit':
		name => 'monit',
		enable => true,
		ensure => running,
		hasstatus => true,
		hasrestart => true
	}
}
