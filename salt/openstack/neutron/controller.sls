{%- from "neutron/map.jinja" import neutron with context %}

include:
  - keystone
  - .keystone

{{ neutron.name }}:
  pkg.installed:
    - refresh: False
    - pkgs: {{ neutron.pkg }}
    - require:
      - sls: keystone.server
  service.running:
    - names: {{ neutron.service }}
    - enable: True
    - require:
      - pkg: {{ neutron.name }}
    - watch:
      - file: /etc/neutron/neutron.conf

{{ neutron.name }}_sync_db:
  cmd.run:
    - name: neutron-db-manage --config-file /etc/neutron/neutron.conf --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade juno
    - require:
      - file: /etc/neutron/neutron.conf
      - file: /etc/neutron/plugins/ml2/ml2_conf.ini

/etc/neutron/neutron.conf:
  file.managed:
    - source: salt://neutron/files/neutron.conf
    - template: jinja
    - require:
      - pkg: {{ neutron.name }}

/etc/neutron/plugins/ml2/ml2_conf.ini:
  file.managed:
    - source: salt://neutron/files/ml2_conf.ini
    - template: jinja
    - require:
      - pkg: {{ neutron.name }}

