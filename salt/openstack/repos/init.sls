cloud_archive_repo:
  pkgrepo.managed:
    - name: deb http://ubuntu-cloud.archive.canonical.com/ubuntu trusty-updates/juno main
    - file: /etc/apt/sources.list.d/juno.list

ubuntu-cloud-keyring:
  pkg:
    - installed
    - require:
      - pkgrepo: cloud_archive_repo

