#!/usr/bin/env bash

echo
echo "!!! Important !!!"
echo "!!! Docker daemon has to be started outside chroot'ed environment !!!"
echo
echo "##########################"
echo "# Starting Docker Daemon #"
echo "##########################"
echo

export LD_LIBRARY_PATH=$CHROOT_PATH/lib:$CHROOT_PATH/lib64:$CHROOT_PATH/usr/lib:$CHROOT_PATH/usr/lib64:/lib:/lib64:/usr/lib:/usr/lib64
export PATH=$CHROOT_PATH/bin:$CHROOT_PATH/sbin:$CHROOT_PATH/usr/bin:$CHROOT_PATH/usr/sbin

$CHROOT_PATH/bin/docker daemon -D \
 --exec-root=$CHROOT_PATH/var/run/docker \
 --storage-driver=overlay \
 -g $CHROOT_PATH/var/run/docker \
 -H unix://$CHROOT_PATH/var/run/docker.sock

