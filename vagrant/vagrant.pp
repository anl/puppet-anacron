# Include this class:
class { 'anacron':
  jobs => {
    'duplicity_daily'  => {
      command => '/opt/duplicity/bin/daily-backup',
      delay   => 60,
      period  => 1,
    },
    'zfs_daily_snap'   => {
      command => '/usr/local/bin/zfs-snapshot.sh tank daily 15',
      comment => 'ZFS daily snapshot',
      delay   => 15,
      period  => 1,
    },
    'zfs_monthly_snap' => {
      command => '/usr/local/bin/zfs-snapshot.sh tank monthly 13',
      comment => 'ZFS monthly snapshot',
      delay   => 30,
      period  => '@monthly',
    },
  }
}
