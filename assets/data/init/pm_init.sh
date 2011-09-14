#!/system/bin/sh

log -p I -t boot "Starting init.d ..."
busybox run-parts /system/etc/init.d