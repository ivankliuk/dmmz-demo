Docker, Zookeeper, Mesos and Marathon (DMMZ)
============================================

This manual describes step by step installation Docker, Zookeeper, Mesos and 
Marathon on chroot'ed Linux environment. It's considered current user has 
``sudo`` access to the system.

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

2) In order to start Zookeeper, Mesos, Marathon run next:
```bash
sudo chroot $CHROOT_PATH
./start_zmm.sh &
```
