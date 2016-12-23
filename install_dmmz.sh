#!/usr/bin/env bash

echo
echo "#####################"
echo "# Installing Docker #"
echo "#####################"
echo

# Add yum repository
tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF

yum install -y docker-engine-1.11.0

echo
echo "####################"
echo "# Installing Mesos #"
echo "####################"
echo

# Fetch the Apache Maven repo file.
wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo

# Install the EPEL repo so that we can pull in 'libserf-1' as part of our
# subversion install below.
yum install -y epel-release

tee /etc/yum.repos.d/wandisco-svn.repo <<-'EOF'
[WANdiscoSVN]
name=WANdisco SVN Repo 1.9
enabled=1
baseurl=http://opensource.wandisco.com/centos/7/svn-1.9/RPMS/$basearch/
gpgcheck=1
gpgkey=http://opensource.wandisco.com/RPM-GPG-KEY-WANdisco
EOF

# Install essential development tools.
yum groupinstall -y "Development Tools"

# Install other Mesos dependencies.
yum install -y apache-maven python-devel java-1.8.0-openjdk-devel
yum install -y zlib-devel libcurl-devel openssl-devel cyrus-sasl-devel cyrus-sasl-md5
yum install -y apr-devel subversion-devel apr-util-devel

# Install Mesos
rpm -Uvh http://repos.mesosphere.com/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm
yum install -y install mesos

echo
echo "####################################"
echo "# Installing Marathon and Zookeper #"
echo "####################################"
echo

# Install Marathon
wget http://downloads.mesosphere.com/marathon/v1.3.5/marathon-1.3.5.tgz
tar -xzf marathon-1.3.5.tgz

# Install Zookeeper
wget -q http://apache.volia.net/zookeeper/zookeeper-3.4.9/zookeeper-3.4.9.tar.gz
tar -xzf zookeeper-3.4.9.tar.gz
cd zookeeper-3.4.9/
cp conf/zoo_sample.cfg conf/zoo.cfg
