{% from 'memcached/map.jinja' import memcached with context %}

memcached:
  pkg:
    - installed
    - name: {{ memcached.server }}
  service:
    - running
    - enable: True
    - name: {{ memcached.service }}
    - require:
      - pkg: memcached
    - watch:
      - file: /etc/memcached.conf

/etc/memcached.conf:
  file:
    - managed
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - source: salt://memcached/templates/memcached.conf
    - require:
      - pkg: memcached
