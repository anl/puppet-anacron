# == Class: anacron
#
# Install and configure anacron.
#
# === Parameters
#
# [*default_jobs*]
#   Include OS-installed default jobs in anacrontab.  Default: true
#
# [*jobs*]
#   Hash of jobs to write to anacrontab.  Keys are job-identifiers;
#   values are hashes with the following keys:
#   - command: Command to execute
#   - comment: Comment to be included above job line in anacrontab;
#   optional.
#   - delay:   Minutes to delay job start; must be integer
#   - period:  Frequency of job runs; must be integer or "@monthly".
#
# === Examples
#
# class { 'anacron':
#   jobs => {
#     'duplicity_daily' => {
#       command => '/opt/duplicity/bin/daily-backup',
#       delay   => 60,
#       period  => 1,
#     },
#     'zfs_daily_snap' => {
#       command => '/usr/local/bin/zfs-snapshot.sh tank daily 15',
#       comment => 'ZFS daily snapshot',
#       delay   => 15,
#       period  => 1,
#     },
#     'zfs_monthly_snap' => {
#       command => '/usr/local/bin/zfs-snapshot.sh tank monthly 13',
#       comment => 'ZFS monthly snapshot',
#       delay   => 30,
#       period  => '@monthly',
#     },
#   }
# }
#
# === Authors
#
# Andrew Leonard
#
# === Copyright
#
# Copyright 2013 Andrew Leonard
#
class anacron (
  $default_jobs = true,
  $jobs = {}
  ) inherits anacron::params {

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
