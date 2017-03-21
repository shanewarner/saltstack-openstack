Darkstarnet LAB: Deploy Openstack cluster with SaltStack
=========

Collection of salt states for Openstack cluster deployment, used in my personal development lab. Optional orchestration runner for Ceph cluster deployment included, however these states are configured for NFS. These are states I was able to piece together when available and reworked to be formulas. Others were written from scratch due to nothing else being available.

This is currently being successfully used to deploy Ocata on Ubuntu 16.04, using 1 controller and 3 compute nodes. It will most definitely need some tweaking to work on a multiple controller environment.

Prepare your environment
==============

First you need Salt master and minions installed and running on all nodes and minions keys should be accepted.

Networking should also be configured. There are custom networking templates for the darkstarnet lab in this repository that should work with little to no tweaking on other environments. This is currently not a formula due to the saltstack network module not working with bonds on Ubuntu 14 Trusty.

After networking has been configured the journal and main ceph partitions need to be clean. It may be required to install ceph and ceph-disk zap these if the orchestration run fails.

Outside of the afformentioned everything else aims to be a formula based on pillar data.

Configuration options
--------------

OPTIONAL CEPH:
NOTE: Currently there must be one and one only 'ceph-admin' role defined,typically on the first node in the environment listing. This node will become the admin node and the initial mon node for provisioning the others.

You will need to edit pillar/openstack/data/*.sls to match your configuration and environment.

Proceed with deployment step after changes are done.

OpenStack Deployment
==============

The openstack states are not currently setup for orchestration. Please reference the base top.sls for ordering of states and role assignment examples. This is fairly self explanatory, however I will try to document it more in the future.

Ceph Deployment
==============

First you need to run highstate to add roles to minions based on environment.sls file:

    salt '*' state.highstate

To start Ceph cluster deployment run orchestrate state from Salt master:

    salt-run -l debug state.orchestrate orchestrate.ceph
    
It will take few minutes to complete. Then you can check ceph cluster status from master:

    salt 'ceph-node01' cmd.run 'ceph -s'

TODO (Manually setup in the lab right now)
===============
1) Swift salt state
2) Trove salt state
3) LBaaS salt state
