class miyw_puppet-runner (
                $sitename = 'template.pp',
                $log = 'false',
		$basedir = '/opt/puppet/',
		$cron = 'present',
		$cron_min = '*/5',
        ){



        file { "$basedir" :
                ensure => "directory",
                recurse => 'true',
        }

        file { "$basedir/scripts/" :
                ensure => "directory",
                recurse => 'true',
        }

        file { "$basedir/repo/" :
                ensure => "directory",
                recurse => 'true',
        }


        file { "$basedir/scripts/puppet-runner.sh":
                content =>      template('miyw_puppet-runner/puppet-runner.erb'),
                mode    =>      '0755',
        }

        file { '/sbin/puppet-runner':
                ensure => 'link',
                target => "$basedir/scripts/puppet-runner.sh',
        }

	cron { "puppet-runner $sitename script":
                        command         =>      "/sbin/puppet-runner",
                        ensure          =>      $cron,
                        user            =>      'root',
                        minute          =>      $cron_min,
                }
}
