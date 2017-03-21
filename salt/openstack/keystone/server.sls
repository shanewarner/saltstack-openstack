{%- from "keystone/map.jinja" import keystone with context %}

include:
  - memcached
  - mysql

{{ keystone.name }}:
  pkg.installed:
    - name: {{ keystone.pkg }}
    - require:
      - sls: mysql.database

  service.running:
    - name: {{ keystone.service }}
    - enable: True
    - restart: True
    - require:
      - pkg: {{ keystone.name }}
      - file: /etc/keystone/keystone.conf
      - file: /etc/keystone/keystone-paste.ini
    - watch:
      - file: /etc/keystone/keystone.conf
      - file: /etc/keystone/keystone-paste.ini

{{ keystone.name }}_sync_db:
  cmd.run:
    - name: keystone-manage db_sync
    - require:
      - file: /etc/keystone/keystone.conf

/etc/keystone/keystone.conf:
  file.managed:
    - source: salt://keystone/files/keystone.conf
    - template: jinja
    - require:
      - pkg: {{ keystone.name }}

/etc/keystone/keystone-paste.ini:
  file.managed:
    - source: salt://keystone/files/keystone-paste.ini
    - template: jinja
    - require:
      - pkg: {{ keystone.name }}
