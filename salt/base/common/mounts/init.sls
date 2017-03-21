{% set host = salt['config.get']('fqdn') -%}

nfs-common:
  pkg:
    - installed
    - name: nfs-common

{% for dev in salt['pillar.get'](host + ':mounts') %}
{{ salt['pillar.get'](host + ':mounts:' + dev + ':target') }}:
  mount.mounted:
    {% if salt['pillar.get'](host + ':mounts:' + dev + ':fstype') == 'nfs' %}
    - device: {{ salt['pillar.get'](host + ':mounts:' + dev + ':server') }}:{{ dev }}
    {% else %}
    - device: {{ dev }}
    {% endif %}
    - fstype: {{ salt['pillar.get'](host + ':mounts:' + dev + ':fstype') }}
    - mkmnt: True
    - opts:
    {% if salt['pillar.get'](host + ':mounts:' + dev + ':fstype') == 'nfs' %}
      - auto
    {% else %}
      - defaults
    {% endif %}
    - order: 100
{% endfor %}
