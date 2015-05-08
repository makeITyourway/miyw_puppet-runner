class miyw_puppet-runner (
                $sitename = 'template.pp',
                $log = 'false',
		$basedir = '/opt/puppet/scripts/',
		$cron = 'present',
		$cron_min = '*/5',
        ){



        #file { [ "/opt/scripts/", "/opt/scripts/puppet/", ]:
        file { "$basedir" :
                ensure => "directory",
                recurse => 'true',
        }

#        file { "/opt/mxd-scripts/puppet/" :
#                ensure => "directory",
#                recurse => 'true',
#        }

        file { "$basedir/puppet/puppet-runner.sh":
                content =>      template('puppet-runner/puppet-runner.erb'),
                mode    =>      '0755',
        }

        file { '/sbin/puppet-runner':
                ensure => 'link',
                target => "$basedir/puppet-runner.sh',
        }

	cron { 'run puppet (runner) script':
                        command         =>      "/sbin/puppet-runner",
                        ensure          =>      $cron,
                        user            =>      'root',
                        minute          =>      $cron_min,
                }
}
