class monit::config {
	$config_root = '/etc/monit'
	$http_port = '2812'
	$servicestub_dir = $::operatingsystem ? {
		/(?i-mx:debian)/ => "${monit::config::config_root}/conf.d",
		/(?i-mx:ubuntu)/ => "${monit::config::config_root}/monitrc.d",
	}
	$exe_path = $::operatingsystem ? {
		/(?i-mx:debian|ubuntu)/ => '/usr/bin/env monit'
	}
	$notify_emails = split($::monit_notify_emails, ',')

	file { 'monitconfigroot':
		path => "${monit::config::config_root}",
		ensure => "directory",
		require => Package['monit'],
		owner => 'root',
		group => 'root',
		mode => '0600',
	}

	file { 'service_stub_dir':
		path => "${monit::config::servicestub_dir}",
		ensure => "directory",
	}

	file { 'monitrc':
		path => "${monit::config::config_root}/monitrc",
		ensure => 'file',
		require => File['monitconfigroot', 'service_stub_dir'],
		owner => 'root',
		group => 'root',
		mode => '0600',
		content => template('monit/monitrc.erb'),
	}
}
