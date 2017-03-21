{%- from "nova/map.jinja" import nova with context %}

include:
  - keystone
  - .base
  - .keystone
  - .conf

nova:
  pkg.installed:
    - refresh: False
    - pkgs: {{ nova.controller_pkgs }}
    - require_in:
      - file: /etc/nova/nova.conf
    - require:
      - sls: keystone.server
  service.running:
    - enable: True
    - restart: True
    - names: {{ nova.controller_services }}
    - require:
      - pkg: nova
    - watch:
      - file: /etc/nova/nova.conf

python-memcache:
  pkg.installed:
    - refresh: False

nova_db_sync:
  cmd.run:
    - name: nova-manage db sync
    - require:
      - file: /etc/nova/nova.conf
