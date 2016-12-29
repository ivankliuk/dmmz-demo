#!/usr/bin/env bash

export PATH=$CHROOT_PATH/bin:$CHROOT_PATH/sbin:$CHROOT_PATH/usr/bin:$CHROOT_PATH/usr/sbin

DOCKERD="$CHROOT_PATH/bin/docker daemon \
--exec-root=$CHROOT_PATH/var/run/docker \
--graph=$CHROOT_PATH/var/run/docker \
--host=unix://$CHROOT_PATH/var/run/docker.sock \
--storage-driver=overlay \
--pidfile=$CHROOT_PATH/var/run/docker.pid"

DOCKER_PID=`pgrep docker`

case "$1" in
start)
   ${DOCKERD} &
   ;;
stop)
   kill ${DOCKER_PID}
   ;;
restart)
   $0 stop
   $0 start
   ;;
status)
   if [ -z ${DOCKER_PID}  ]; then
      echo dockerd is NOT running
      exit 1
   else
      echo dockerd is running, pid=${DOCKER_PID}
   fi
   ;;
*)
   echo "Usage: $0 {start|stop|status|restart}"
esac

exit 0
