# vi: set ft=yaml.jinja :
admin_setup:
  salt.state:
    - tgt: 'roles:ceph-admin'
    - tgt_type: grain
    - sls: ceph.admin

mon_setup:
  salt.state:
    - tgt: 'roles:ceph-mon'
    - tgt_type: grain
    - sls: ceph.mon
    - require:
      - salt: admin_setup

osd_setup:
  salt.state:
    - tgt: 'roles:ceph-osd'
    - tgt_type: grain
    - sls: ceph.osd
    - require:
      - salt: mon_setup
