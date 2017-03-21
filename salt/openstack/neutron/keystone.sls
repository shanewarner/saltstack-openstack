keystone_neutron_user:
  keystone.user_present:
    - name: neutron
    - password: {{ salt['pillar.get']('neutron:keystone:password') }}
    - email: {{ salt['pillar.get']('neutron:keystone:email') }}
    - tenant: service
    - enable: True
    - roles:
      - service:
        - admin

keystone_neutron_service:
  keystone.service_present:
    - name: neutron
    - service_type: network
    - description: Openstack Neutron Service

keystone_neutron_endpoint:
  keystone.endpoint_present:
    - name: neutron
    - publicurl: http://{{ salt["pillar.get"]("neutron:public_ip") }}:9696
    - internalurl: http://{{ salt["pillar.get"]("neutron:internal_ip") }}:9696
    - adminurl: http://{{ salt["pillar.get"]("neutron:admin_ip") }}:9696
