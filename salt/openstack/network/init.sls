{% set host = salt['grains.get']('fqdn') -%}

{% if grains['os'] == 'Ubuntu' %}
/etc/network/interfaces:
  file.managed:
{% if host == 'controller01.darkstarnet' %}
    - source: salt://network/etc/interfaces-controller
{% else %}
    - source: salt://network/etc/interfaces-compute
{% endif %}
    - user: root
    - group: root
    - mode: 644
    - template: jinja

networking:
  service:
    - running
    - enable: True
    - watch:
      - file: /etc/network/interfaces

ifenslave:
  pkg.installed

bridge-utils:
  pkg.installed

vlan:
  pkg.installed

{% endif %}

