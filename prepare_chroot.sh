#!/usr/bin/env bash

echo
echo "#####################################################"
echo "# Installing base system into chroot'ed environment #"
echo "#####################################################"
echo

# Mount virtual system filesystems
mkdir $CHROOT_PATH/dev $CHROOT_PATH/sys $CHROOT_PATH/proc
mount -o rbind /dev $CHROOT_PATH/dev
mount -o rbind /proc $CHROOT_PATH/proc
mount -o rbind /sys $CHROOT_PATH/sys

# Copy DNS config
mkdir $CHROOT_PATH/etc/
cp /etc/resolv.conf $CHROOT_PATH/etc/resolv.conf

# Initialize the RPM database
mkdir -p $CHROOT_PATH/var/lib/rpm
rpm --rebuilddb --root=$CHROOT_PATH

# Install base system and additional packages
curl -O http://mirror.centos.org/centos/7/os/x86_64/Packages/centos-release-7-3.1611.el7.centos.x86_64.rpm
rpm -i --root=$CHROOT_PATH --nodeps centos-release-7-3.1611.el7.centos.x86_64.rpm
yum --installroot=$CHROOT_PATH install -y rpm-build yum tar wget git mc net-tools

# Start installation within chroot'ed environment
chroot $CHROOT_PATH /bin/bash -c "su - -c /install_dmmz.sh"
