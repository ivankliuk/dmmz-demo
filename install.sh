#!/usr/bin/env bash


echo
echo "#####################################################"
echo "# Installing base system into chroot'ed environment #"
echo "#####################################################"
echo

# Initialize the RPM database
mkdir -p $CHROOT_PATH/var/lib/rpm
rpm --rebuilddb --root=$CHROOT_PATH

# Install base system and additional packages
curl -O http://mirror.centos.org/centos/7/os/x86_64/Packages/centos-release-7-3.1611.el7.centos.x86_64.rpm
rpm -i --root=$CHROOT_PATH --nodeps centos-release-7-3.1611.el7.centos.x86_64.rpm
yum --installroot=$CHROOT_PATH install -y rpm-build yum

# Copy DNS config
mkdir $CHROOT_PATH/etc/
cp /etc/resolv.conf $CHROOT_PATH/etc/resolv.conf

# Install docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o $CHROOT_PATH/docker-compose
chmod +x $CHROOT_PATH/docker-compose

echo
echo "#####################"
echo "# Installing Docker #"
echo "#####################"
echo

# Add yum repository
tee $CHROOT_PATH/etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF

# Install Docker engine
chroot $CHROOT_PATH /bin/bash -c "yum install -y docker-engine-1.12.5"

# Update shared library cache
echo "$CHROOT_PATH/usr/lib64" > $CHROOT_PATH/etc/ld.so.conf.d/docker.conf
ldconfig -f $CHROOT_PATH/etc/ld.so.conf
