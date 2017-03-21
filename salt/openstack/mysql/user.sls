{% from "mysql/defaults.yaml" import rawmap with context %}
{%- set mysql = salt['grains.filter_by'](rawmap, grain='os', merge=salt['pillar.get']('mysql:server:lookup')) %}
{%- set mysql_root_pass = salt['pillar.get']('mysql:server:root_password', 'somepass') %}

{% set user_states = [] %}

include:
  - mysql.python

{% for user in salt['pillar.get']('mysql:user', []) %}
{% set state_id = 'mysql_user_' ~ loop.index0 %}
{% set password = salt['pillar.get']('mysql:user:' + user + ':password') %}
{{ state_id }}:
  mysql_user.present:
    - name: {{ user }}
    - host: '{{ salt['pillar.get']('mysql:user:' + user + ':host') }}'
  {%- if salt['pillar.get']('mysql:user:' + user + ':password_hash', '') != '' %}
    - password_hash: '{{ salt['pillar.get']('mysql:user:' + user + ':password_hash') }}'
  {%- elif password is defined and password != None %}
    - password: '{{ password }}'
  {%- else %}
    - allow_passwordless: True
  {%- endif %}
    - connection_host: localhost
    - connection_user: root
    {% if mysql_root_pass %}
    - connection_pass: '{{ mysql_root_pass }}'
    {% endif %}
    - connection_charset: utf8

{% for db in salt['pillar.get']('mysql:user:' + user + ':databases') %}
{% set table = salt['pillar.get']('mysql:user:' + user + ':databases:' + db + ':table', '*')%}
{% set grants = salt['pillar.get']('mysql:user:' + user + ':databases:' + db + ':grants')%}
{% set grant_option = salt['pillar.get']('mysql:user:' + user + ':databases:' + db + ':grant_option')%}
{{ state_id ~ '_' ~ loop.index0 }}:
  mysql_grants.present:
    - name: {{ user ~ '_' ~ db  ~ '_' ~ table | default('all') }}
    - grant: {{grants|join(",")}}
    - database: '{{ db }}.{{ table | default('*') }}'
    - grant_option: {{ grant_option | default(False) }}
    - user: {{ user }}
    - host: '{{ salt['pillar.get']('mysql:user:' + user + ':host') }}'
    - connection_host: localhost
    - connection_user: root
    {% if mysql_root_pass -%}
    - connection_pass: '{{ mysql_root_pass }}'
    {% endif %}
    - connection_charset: utf8
    - require:
      - mysql_user: {{ user }}
{% endfor %}

{% do user_states.append(state_id) %}
{% endfor %}
