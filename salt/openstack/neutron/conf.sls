neutron-plugin-ml2:
  pkg.installed:
    - refresh: False

/etc/neutron/neutron.conf:
  file.managed:
    - source: salt://neutron/files/neutron.conf
    - template: jinja
