ceph:
  global:
    fsid: 71e69067-b297-462c-af57-c4d4b1ae2782
    public_network: 10.10.0.0/24
    cluster_network: 10.20.0.0/24
  client:
    rbd_cache: true
    rbd_cache_size: 134217728
  osd:
    journal_size: 512
    pool_default_size: 3
    crush_update_on_start: "true"
    pool_default_min_size: 1
    pool_default_pg_num: 128
    pool_default_pgp_num: 128
    crush_chooseleaf_type: 1
    filestore_merge_threshold: 40
    filestore_split_multiple: 8
    op_threads: 8
  mon:
    interface: eth0

