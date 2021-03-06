class monit::config (
	$notify_server,
	$notify_emails,
) {
	$config_root = '/etc/monit'
	$http_port = '2812'
	$servicestub_dir = $::operatingsystem ? {
		/(?i-mx:debian|ubuntu)/ => "${monit::config::config_root}/conf.d"
	}
	$exe_path = $::operatingsystem ? {
		/(?i-mx:debian|ubuntu)/ => '/usr/bin/env monit'
	}
	$notify_emails_arr = split($notify_emails, ',')
	if $notify_server != undef {
		$notify_server_def = split($notify_server, ':')
	} else {
		$notify_server_def = [undef, undef]
	}
	$mail_server_ip = $notify_server_def[0]
	$mail_server_port = $notify_server_def[1]

	File {
		owner => 'root',
		group => 'root',
	}

	file { 'monitconfigroot':
		path => "${monit::config::config_root}",
		ensure => "directory",
		mode => '0500',
	}

	# Contains only Puppet created service stubs
	file { 'service_stub_dir':
		path => "${monit::config::servicestub_dir}",
		ensure => "directory",
		require => File['monitconfigroot'],
		mode => '0500',
		recurse => true,
		purge => true
	}

	file {'custom_dir':
		path => "${monit::config::config_root}/custom.d",
		ensure => "directory",
		require => File['monitconfigroot'],
		mode => '0500',
	}

	file {"${custom_dir}/.keep":
		ensure => file,
		mode => '0400',
		content => '# Intentionally left blank',
		require => File['custom_dir']
	}

	file { 'monitrc':
		path => "${monit::config::config_root}/monitrc",
		ensure => 'file',
		require => File['monitconfigroot', 'service_stub_dir'],
		mode => '0400',
		content => template('monit/monitrc.erb'),
	}
}
