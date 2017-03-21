# vi: set ft=yaml.jinja :

openstack:
  '*':
    - data.mounts
    - environment
    - mine_functions
    - data.network
    - data.ceph
  'roles:openstack-controller':
    - match: grain
    - data.mysql
    - data.rabbitmq
    - data.openstack
  'roles:openstack-compute':
    - match: grain
    - data.mysql
    - data.rabbitmq
    - data.openstack

