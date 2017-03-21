{%- from "neutron/map.jinja" import neutron with context %}

neutron-l3-agent:
  pkg.installed:
    - refresh: False
    - pkgs: {{ neutron.network_pkgs }}
    - require_in:
      - file: /etc/neutron/neutron.conf
  service.running:
    - enable: True
    - restart: True
    - names: {{ neutron.network_services }}
    - require:
      - pkg: neutron-l3-agent
      - file: /etc/neutron/neutron.conf
    - watch:
      - file: /etc/neutron/neutron.conf
      - file: /etc/neutron/l3_agent.ini
      - file: /etc/neutron/dhcp_agent.ini
      - file: /etc/neutron/dnsmasq-neutron.conf
      - file: /etc/neutron/metadata_agent.ini

ovs-vsctl:
  cmd.run:
    - name: ovs-vsctl add-br br-ex
    - require:
      - file: /etc/neutron/neutron.conf
      - file: /etc/neutron/l3_agent.ini
      - file: /etc/neutron/dhcp_agent.ini
      - file: /etc/neutron/dnsmasq-neutron.conf
      - file: /etc/neutron/metadata_agent.ini

ovs-vsctl-add-port:
  cmd.run:
    - name: ovs-vsctl add-port br-ex eth1
    - require:
      - file: /etc/neutron/neutron.conf
      - file: /etc/neutron/l3_agent.ini
      - file: /etc/neutron/dhcp_agent.ini
      - file: /etc/neutron/dnsmasq-neutron.conf
      - file: /etc/neutron/metadata_agent.ini

/etc/neutron/l3_agent.ini:
  file.managed:
    - source: salt://neutron/files/l3_agent.ini
    - template: jinja
    - require:
      - pkg: neutron-l3-agent

/etc/neutron/dhcp_agent.ini:
  file.managed:
    - source: salt://neutron/files/dhcp_agent.ini
    - template: jinja
    - require:
      - pkg: neutron-l3-agent

/etc/neutron/dnsmasq-neutron.conf:
  file.managed:
    - source: salt://neutron/files/dnsmasq-neutron.conf
    - template: jinja
    - require:
      - pkg: neutron-l3-agent

/etc/neutron/metadata_agent.ini:
  file.managed:
    - source: salt://neutron/files/metadata_agent.ini
    - template: jinja
    - require:
      - pkg: neutron-l3-agent

