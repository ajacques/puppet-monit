# Info #
This repository represents a Puppet module for automatically creating and managing Monit service monitors. Other modules can automatically inject health checks any time a new service is installed.

# Example #
<pre><code>monit::service_monitor {'monit_slapd_srv':
	service_name => 'slapd',
	pid_file => 'slapd.pid',
	start_path => "/etc/init.d/slapd start",
	stop_path => "/etc/init.d/slapd stop",
	max_restarts => 3,
	max_memory => '64 MB'
}
</code></pre>
