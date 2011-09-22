#!/system/bin/sh

# check for init for stock or roms without
busybox mount -o remount,rw /system
busybox sed -i 's|doOnboot=.*|doOnboot=1|' /system/etc/init.d/99mods
busybox rm /system/etc/init.d/99check