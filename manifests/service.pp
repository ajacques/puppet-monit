class monit::service {
	exec { 'reload-monit':
		command => "${monit::config::exe_path}",
		refreshonly => true,
		subscribe => File["${monit::config::servicestub_dir}"],
	}
	service { 'monit':
		name => 'monit',
		enable => true,
		ensure => running,
		require => File['monitrc'],
		hasstatus => true,
		hasrestart => true,
		subscribe => Exec['reload-monit'],
	}
}
