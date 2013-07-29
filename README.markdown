# Example #
<pre><code>
monit::service_monitor {'monit_slapd_srv':
	service_name => 'slapd',
	pid_file => 'slapd.pid',
	start_path => "/etc/init.d/slapd start",
	stop_path => "/etc/init.d/slapd stop",
	max_restarts => 3,
	max_memory => '64 MB'
}
</code></pre>