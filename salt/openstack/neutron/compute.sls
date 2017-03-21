{%- from "neutron/map.jinja" import neutron with context %}

include:
  - .conf

neutron-plugin-openvswitch-agent:
  pkg.installed:
    - refresh: False
    - pkgs: {{ neutron.compute_pkgs }}
    - require:
      - file: /etc/neutron/neutron.conf
  service.running:
    - names: {{ neutron.compute_services }}
    - enable: True
    - require:
      - pkg: neutron-plugin-openvswitch-agent
    - watch:
      - file: /etc/neutron/neutron.conf
      - file: /etc/neutron/plugins/ml2/ml2_conf.ini

/etc/neutron/plugins/ml2/ml2_conf.ini:
  file.managed:
    - source: salt://neutron/files/ml2_conf.ini
    - template: jinja
    - require:
      - pkg: neutron-plugin-openvswitch-agent
