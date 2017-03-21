# Mount points listed here will be automatically mounted and added to fstab
controller01.darkstarnet:
  mounts:
    /dev/sda2:
      target: /var/lib/mysql
      fstype: xfs
    /images:
      target: /var/lib/glance/images
      fstype: nfs
      server: 10.30.0.100
compute01.darkstarnet:
  mounts:
#    /dev/sdb1:
#      target: /var/lib/nova/instances
#      fstype: ext4
    /instances:
      target: /var/lib/nova/instances
      fstype: nfs
      server: 10.30.0.100
compute02.darkstarnet:
  mounts:
#    /dev/sdb1:
#      target: /var/lib/nova/instances
#      fstype: ext4
    /instances:
      target: /var/lib/nova/instances
      fstype: nfs
      server: 10.30.0.100
compute03.darkstarnet:
  mounts:
#    /dev/sdb1:
#      target: /var/lib/nova/instances
#      fstype: ext4
    /instances:
      target: /var/lib/nova/instances
      fstype: nfs
      server: 10.30.0.100
