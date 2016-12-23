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
sudo chmod +x prepare_chroot.sh
sudo chmod +x install_dmmz.sh
```

3) Execute ``prepare.sh`` as follows:
```bash
sudo -E ./prepare_chroot.sh
```
