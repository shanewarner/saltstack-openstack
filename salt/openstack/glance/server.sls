{%- from "glance/map.jinja" import glance with context %}
include:
  - keystone
  - .keystone

{{ glance.name }}:
  pkg.installed:
    - refresh: False
    - pkgs: {{ glance.pkg }}
    - require:
      - sls: keystone.server
  service.running:
    - names: {{ glance.service }}
    - enable: True
    - require:
      - pkg: {{ glance.name }}
{% for filename in ["glance-api.conf",
                    "glance-cache.conf",
                    "glance-registry.conf",
                    "glance-api-paste.ini ",
                    "glance-scrubber.conf"] %}
/etc/glance/{{ filename }}:
  file.managed:
    - source: salt://glance/files/{{ filename }}
    - template: jinja
    - require_in:
      - service: {{ glance.name }}
      - cmd: {{ glance.name }}_sync_db
      - cmd: glance-init-images
    - watch_in:
      - service: {{ glance.name }}
{% endfor %}

{{ glance.name }}_sync_db:
  cmd.run:
    - name: glance-manage db_sync

glance-init-images:
  cmd.script:
    - name: salt://glance/scripts/glance-init.sh
    - stateful: True
    - require: 
      - service: {{ glance.name }}
