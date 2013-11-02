# == Class: anacron::params
#
# Parameters class for anacron module.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Examples
#
# class anacron inherits anacron::params {}
#
# === Authors
#
# Andrew Leonard
#
# === Copyright
#
# Copyright 2013 Andrew Leonard
#
class anacron::params {

  case $::operatingsystem {
    ubuntu: {
      $crontab = '/etc/anacrontab'
      $package = 'anacron'
      $service = 'anacron'
    }
    default: {
      fail("Unsupported os: ${::operatingsystem}")
    }
  }
}
