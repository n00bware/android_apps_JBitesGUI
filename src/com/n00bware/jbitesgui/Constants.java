
package com.n00bware.jbitesgui;

public final class Constants {

    private Constants() {
        // private constructor so nobody can instantiate this class
    }

    public static final String DISABLE = "disable";

    // Strings for Mount
    public static final String MOUNT_PREF = "pref_mount";

    public static final String REVERT_DONT_REBOOT = "busybox sed -i \"/doLoop/ c doLoop=1\" /system/etc/init.d/99mods";

    public static final String DONT_REBOOT = "busybox sed -i \"/doLoop/ c doLoop=0\" /system/etc/init.d/99mods";

    public static final String SYMLINK_QUERTY = "ln qwerty.kcm.bin /system/usr/keychars/cpcap-key.kcm.bin /system/usr/keychars/qtouch-touchscreen.kcm.bin";

    public static final String SYMLINK_TOOLBOX = "ln toolbox /system/bin/cat /system/bin/cmp /system/bin/date /system/bin/dd /system/bin/dmesg /system/bin/getevent /system/bin/getprop /system/bin/hd /system/bin/id /system/bin/ifconfig /system/bin/iftop /system/bin/insmod /system/bin/ioctl /system/bin/ionice /system/bin/kill /system/bin/log /system/bin/lsmod /system/bin/nandread /system/bin/netstat /system/bin/newfs_msdos /system/bin/notify /system/bin/printenv /system/bin/ps /system/bin/reboot /system/bin/renice /system/bin/rmdir /system/bin/rmmod /system/bin/route /system/bin/schedtop /system/bin/sendevent /system/bin/setconsole /system/bin/setprop /system/bin/sleep /system/bin/smd /system/bin/start /system/bin/stop /system/bin/sync /system/bin/top /system/bin/uptime /system/bin/vmstat /system/bin/watchprops /system/bin/wipe";

}
