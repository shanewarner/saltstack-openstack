nodes:
  controller01.darkstarnet:
    roles:
      - ceph-admin
      - ceph-mon
      - openstack-controller
  compute01.darkstarnet:
    roles:
      - ceph-osd
      - ceph-mon
      - openstack-compute
    devs:
      sdb:
        journal: sda2
  compute02.darkstarnet:
    roles:
      - ceph-osd
      - ceph-mon
      - openstack-compute
    devs:
      sdb:
        journal: sda2
  compute03.darkstarnet:
    roles:
      - ceph-osd
      - ceph-mon
      - openstack-compute
    devs:
      sdb:
        journal: sda2

# Examples:
# MON and OSD on separate nodes.
# Journal on same drive with OSD.
#nodes:
#  ceph-node01:
#    roles:
#      - ceph-mon
#  ceph-node02:
#    roles:
#      - ceph-osd
#    devs:
#      sdb:
#        journal: sdb
#      sdc:
#        journal: sdc
