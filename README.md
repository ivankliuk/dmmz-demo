Docker, Zookeeper, Mesos and Marathon (DMMZ)
============================================

This manual describes step by step installation Docker, Zookeeper, Mesos and 
Marathon on chroot'ed Linux environment. It's considered current user has 
``sudo`` access to the system.

Tracking of changes in root file system
---------------------------------------

If you are not going to track changes in root file system skip these steps.

1) Install ``inotify-tools``:
```bash
sudo curl -O http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm
sudo rpm -ivh epel-release-7-8.noarch.rpm
sudo yum install -y inotify-tools
```

2) Run ``inotifywait`` in background:
```bash
sudo inotifywait -e create,delete,modify,move -mrq / @/opt/nerve @/dev @/sys @/proc @/var @/run > /var/log/inotify.log &
```

Now all the changes are made in root file system are being reflected in
``/var/log/inotify.log``.

Installation
------------

1) Specify directory for chroot'ed environment via environment variable and
change current directory to it:
```bash
export CHROOT_PATH=/foo/bar
cd $CHROOT_PATH
```

2) Fetch the scripts and make them executable:
```bash
sudo curl -O https://raw.githubusercontent.com/ivankliuk/dmmz-demo/master/prepare_chroot.sh
sudo curl -O https://raw.githubusercontent.com/ivankliuk/dmmz-demo/master/install_dmmz.sh
sudo curl -O https://raw.githubusercontent.com/ivankliuk/dmmz-demo/master/start_dockerd.sh
sudo curl -O https://raw.githubusercontent.com/ivankliuk/dmmz-demo/master/start_zmm.sh
sudo chmod +x prepare_chroot.sh install_dmmz.sh start_dockerd.sh start_zmm.sh
```

3) Execute ``prepare.sh`` as follows:
```bash
sudo -E ./prepare_chroot.sh
```

Services execution
------------------

1) Initially, start docker daemon. It has to be started outside the chroot'ed
environment:
```bash
sudo -E ./start_dockerd.sh &
```

2) To start Zookeeper, Mesos, Marathon run the following:
```bash
chroot $CHROOT_PATH
./start_zmm.sh &
```
