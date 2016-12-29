Docker, Zookeeper, Mesos and Marathon
=====================================

This manual describes step by step installation Docker, Zookeeper, Mesos and 
Marathon on Linux environment. It's considered current user has 
``sudo`` access to the system.

Installation
------------

1) Specify directory for chroot'ed environment via environment variable and
change current directory to it:
```bash
sudo -s
export CHROOT_PATH=/foo/bar
cd $CHROOT_PATH
```

2) Fetch the scripts and make them executable:
```bash
curl -O https://raw.githubusercontent.com/ivankliuk/dmmz-demo/master/install.sh
curl -O https://raw.githubusercontent.com/ivankliuk/dmmz-demo/master/dockerd.sh
curl -O https://raw.githubusercontent.com/ivankliuk/dmmz-demo/master/docker-compose.yaml
chmod +x install.sh dockerd.sh
```

3) Execute ``install.sh`` as follows:
```bash
./install.sh
```

Services execution
------------------

1) Start docker daemon:
environment:
```bash
./dockerd.sh start
```

2) Deploy Zookeeper, Mesos and Marathon using ``docker-compose``:
```bash
$CHROOT_PATH/docker-compose -H unix://$CHROOT_PATH/var/run/docker.sock up
```
