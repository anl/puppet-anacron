# == Class: anacron
#
# Install and configure anacron.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Examples
#
#  class { anacron:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Andrew Leonard
#
# === Copyright
#
# Copyright 2013 Andrew Leonard
#
class anacron inherits anacron::params {

  package { $anacron::params::package:
    ensure => present,
  }

  file { $anacron::params::crontab:
    content => template('anacron/anacrontab.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    require => Package[$anacron::params::package],
  }

  service { $anacron::params::service:
    enable  => true,
    require => Package[$anacron::params::package],
  }
}
