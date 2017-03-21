rabbitmq:
  erlang_cookie: kdsfdsfds-83459834qdfdfj

  plugins:
    - rabbitmq_management
    - rabbitmq_management_visualiser

  nodes:
    - controller01.darkstarnet

#  cluster:
#    controller01.darkstarnet: 10.10.0.2
#    node2: 127.0.0.2
#    node3: 127.0.0.3

#  vhosts:
#    '/':
#      state: present

#  policies:
#    central:
#      vhost: '/bla'
#      pattern: '^central\.'
#      definition: '{"ha-mode": "all", "ha-sync-mode": "automatic", "message-ttl": 1800000}'

  users:
    guest:
      state: absent

    admin:
      password: "sing guitar truck whale black"
      tags: administrator
      perms:
        - '/':
          - '.*'
          - '.*'
          - '.*'

    openstack:
      password: "this tree rose strange rock"
      tags: administrator
      perms:
        - '/':
          - '.*'
          - '.*'
          - '.*'
