
package com.n00bware.jbitesgui;

public final class Constants {

    private Constants() {
        // private constructor so nobody can instantiate this class
    }

    public static final String SHOWBUILD_PATH = "/system/tmp/showbuild";
    public static final String DISABLE = "disable";

    // Strings for Mount
    public static final String MOUNT_PREF = "pref_mount";

    // Strings for installScripts
    public static final String SCRIPTS_PATH = "/data/";

    //used for download and install
    public static final String WGET_JBITES = "busybox wget -q -O /sdcard/mods/temp/jbitesgui_temp.zip http://www50.multiupload.com:81/files/14F6004BA6367A2C77A4355101CB4C2930D825AD3A8FF7DF75C6A7E1F5DE5EBC1F79C14A755612C81721590849E9F23829AC41A79EF2FF556571C4D4D1C16CC1BA9EC592937CF7E4255834EF3A9551EE8071/JakebitesModsv11-GB.zip";
    public static final String UNZIP_JBITES = "unzip /sdcard/mods/temp/jbitesgui_temp.zip -d /sdcard/mods";
    public static final String INSTALL_JBITES_SYSTEM = "cp -pRf /sdcard/mods/system/* /system/*";
    public static final String INSTALL_JBITES_SCRIPTS = "cp -pRf /sdcard/mods/data/* /data/*";
    public static final String CP_MODS_0 = "cp -f /sdcard/mods/data/mods/* /sdcard/mods/*";
    public static final String CP_MODS_1 = "cp -f /sdcard/mods/system/modules/* /sdcard/mods/*";
    public static final String CP_MODS_2 = "cp -f /sdcard/mods/data/oc/* /sdcard/mods/*";
    public static final String CP_MODS_3 = "cp -pf /sdcard/mods/data/cron/root /sdcard/mods/root";
    public static final String CLEAN_MODS_DIR = "rm -rf /sdcard/mods/META-INF /sdcard/mods/data /sdcard/mods/system /sdcard/mods/temp /sdcard/mods/jbitesgui_temp.zip";

    public static final String REVERT_DONT_REBOOT = "busybox sed -i \"/doLoop/ c doLoop=1 /system/etc/init.d/99mods";

    public static final String DONT_REBOOT = "busybox sed -i \"/doLoop/ c doLoop=0 /system/etc/init.d/99mods";

    //doesn't work bash cuts this command in half before executing with error
    public static final String SYMLINK_BUSYBOX = "ln busybox /system/xbin/[ /system/xbin/[[ /system/xbin/acpid /system/xbin/addgroup /system/xbin/adduser /system/xbin/adjtimex /system/xbin/arp /system/xbin/arping /system/xbin/ash /system/xbin/awk /system/xbin/basename /system/xbin/beep /system/xbin/blkid /system/xbin/bootchartd /system/xbin/brctl /system/xbin/bunzip2 /system/xbin/bzcat /system/xbin/bzip2 /system/xbin/cal /system/xbin/cat /system/xbin/catv /system/xbin/chat /system/xbin/chattr /system/xbin/chgrp /system/xbin/chmod /system/xbin/chown /system/xbin/chpasswd /system/xbin/chpst /system/xbin/chroot /system/xbin/chrt /system/xbin/chvt /system/xbin/cksum /system/xbin/clear /system/xbin/cmp /system/xbin/comm /system/xbin/cp /system/xbin/cpio /system/xbin/crond /system/xbin/crontab /system/xbin/cryptpw /system/xbin/cttyhack /system/xbin/cut /system/xbin/date /system/xbin/dc /system/xbin/dd /system/xbin/deallocvt /system/xbin/delgroup /system/xbin/deluser /system/xbin/depmod /system/xbin/devmem /system/xbin/df /system/xbin/dhcprelay /system/xbin/diff /system/xbin/dirname /system/xbin/dmesg /system/xbin/dnsd /system/xbin/dnsdomainname /system/xbin/dos2unix /system/xbin/du /system/xbin/dumpkmap /system/xbin/dumpleases /system/xbin/echo /system/xbin/ed /system/xbin/egrep /system/xbin/eject /system/xbin/env /system/xbin/envdir /system/xbin/envuidgid /system/xbin/ether-wake /system/xbin/expand /system/xbin/expr /system/xbin/fakeidentd /system/xbin/false /system/xbin/fbset /system/xbin/fbsplash /system/xbin/fdflush /system/xbin/fdformat /system/xbin/fdisk /system/xbin/fgconsole /system/xbin/fgrep /system/xbin/find /system/xbin/findfs /system/xbin/flock /system/xbin/fold /system/xbin/free /system/xbin/freeramdisk /system/xbin/fsck /system/xbin/fsck.minix /system/xbin/fsync /system/xbin/ftpd /system/xbin/ftpget /system/xbin/ftpput /system/xbin/fuser /system/xbin/getopt /system/xbin/getty /system/xbin/grep /system/xbin/gunzip /system/xbin/gzip /system/xbin/halt /system/xbin/hd /system/xbin/hdparm /system/xbin/head /system/xbin/hexdump /system/xbin/hostid /system/xbin/hostname /system/xbin/httpd /system/xbin/hush /system/xbin/hwclock /system/xbin/id /system/xbin/ifconfig /system/xbin/ifdown /system/xbin/ifenslave /system/xbin/ifplugd /system/xbin/ifup /system/xbin/inetd /system/xbin/init /system/xbin/insmod /system/xbin/install /system/xbin/ionice /system/xbin/ip /system/xbin/ipaddr /system/xbin/ipcalc /system/xbin/ipcrm /system/xbin/ipcs /system/xbin/iplink /system/xbin/iproute /system/xbin/iprule /system/xbin/iptunnel /system/xbin/kbd_mode /system/xbin/kill /system/xbin/killall /system/xbin/killall5 /system/xbin/klogd /system/xbin/last /system/xbin/length /system/xbin/less /system/xbin/linux32 /system/xbin/linux64 /system/xbin/linuxrc /system/xbin/ln /system/xbin/loadfont /system/xbin/loadkmap /system/xbin/logger /system/xbin/login /system/xbin/logname /system/xbin/logread /system/xbin/losetup /system/xbin/lpd /system/xbin/lpq /system/xbin/lpr /system/xbin/ls /system/xbin/lsattr /system/xbin/lsmod /system/xbin/lspci /system/xbin/lsusb /system/xbin/lzcat /system/xbin/lzma /system/xbin/lzop /system/xbin/lzopcat /system/xbin/makedevs /system/xbin/makemime /system/xbin/man /system/xbin/md5sum /system/xbin/mdev /system/xbin/mesg /system/xbin/microcom /system/xbin/mkdir /system/xbin/mkdosfs /system/xbin/mke2fs /system/xbin/mkfifo /system/xbin/mkfs.ext2 /system/xbin/mkfs.minix /system/xbin/mkfs.vfat /system/xbin/mknod /system/xbin/mkpasswd /system/xbin/mkswap /system/xbin/mktemp /system/xbin/modinfo /system/xbin/modprobe /system/xbin/more /system/xbin/mount /system/xbin/mountpoint /system/xbin/mt /system/xbin/mv /system/xbin/nameif /system/xbin/nc /system/xbin/netstat /system/xbin/nice /system/xbin/nmeter /system/xbin/nohup /system/xbin/nslookup /system/xbin/ntpd /system/xbin/od /system/xbin/openvt /system/xbin/passwd /system/xbin/patch /system/xbin/pgrep /system/xbin/pidof /system/xbin/ping /system/xbin/ping6 /system/xbin/pipe_progress /system/xbin/pivot_root /system/xbin/pkill /system/xbin/popmaildir /system/xbin/poweroff /system/xbin/printenv /system/xbin/printf /system/xbin/ps /system/xbin/pscan /system/xbin/pwd /system/xbin/raidautorun /system/xbin/rdate /system/xbin/rdev /system/xbin/readahead /system/xbin/readlink /system/xbin/readprofile /system/xbin/realpath /system/xbin/reboot /system/xbin/reformime /system/xbin/renice /system/xbin/reset /system/xbin/resize /system/xbin/rev /system/xbin/rm /system/xbin/rmdir /system/xbin/rmmod /system/xbin/route /system/xbin/rpm /system/xbin/rpm2cpio /system/xbin/rtcwake /system/xbin/run-parts /system/xbin/runlevel /system/xbin/runsv /system/xbin/runsvdir /system/xbin/rx /system/xbin/script /system/xbin/scriptreplay /system/xbin/sed /system/xbin/sendmail /system/xbin/seq /system/xbin/setarch /system/xbin/setconsole /system/xbin/setfont /system/xbin/setkeycodes /system/xbin/setlogcons /system/xbin/setsid /system/xbin/setuidgid /system/xbin/sh /system/xbin/sha1sum /system/xbin/sha256sum /system/xbin/sha512sum /system/xbin/showkey /system/xbin/slattach /system/xbin/sleep /system/xbin/smemcap /system/xbin/softlimit /system/xbin/sort /system/xbin/split /system/xbin/start-stop-daemon /system/xbin/stat /system/xbin/strings /system/xbin/stty /system/xbin/su /system/xbin/sulogin /system/xbin/sum /system/xbin/sv /system/xbin/svlogd /system/xbin/swapoff /system/xbin/swapon /system/xbin/switch_root /system/xbin/sync /system/xbin/sysctl /system/xbin/syslogd /system/xbin/tac /system/xbin/tail /system/xbin/tar /system/xbin/tcpsvd /system/xbin/tee /system/xbin/telnet /system/xbin/telnetd /system/xbin/test /system/xbin/tftp /system/xbin/tftpd /system/xbin/time /system/xbin/timeout /system/xbin/top /system/xbin/touch /system/xbin/tr /system/xbin/traceroute /system/xbin/traceroute6 /system/xbin/true /system/xbin/tty /system/xbin/ttysize /system/xbin/tunctl /system/xbin/udhcpc /system/xbin/udhcpd /system/xbin/udpsvd /system/xbin/umount /system/xbin/uname /system/xbin/unexpand /system/xbin/uniq /system/xbin/unix2dos /system/xbin/unlzma /system/xbin/unlzop /system/xbin/unxz /system/xbin/unzip /system/xbin/uptime /system/xbin/usleep /system/xbin/uudecode /system/xbin/uuencode /system/xbin/vconfig /system/xbin/vi /system/xbin/vlock /system/xbin/volname /system/xbin/wall /system/xbin/watch /system/xbin/watchdog /system/xbin/wc /system/xbin/wget /system/xbin/which /system/xbin/who /system/xbin/whoami /system/xbin/xargs /system/xbin/xz /system/xbin/xzcat /system/xbin/yes /system/xbin/zcat /system/xbin/zcip";

    public static final String SYMLINK_QUERTY = "ln qwerty.kcm.bin /system/usr/keychars/cpcap-key.kcm.bin /system/usr/keychars/qtouch-touchscreen.kcm.bin";

    public static final String SYMLINK_TOOLBOX = "ln toolbox /system/bin/cat /system/bin/cmp /system/bin/date /system/bin/dd /system/bin/dmesg /system/bin/getevent /system/bin/getprop /system/bin/hd /system/bin/id /system/bin/ifconfig /system/bin/iftop /system/bin/insmod /system/bin/ioctl /system/bin/ionice /system/bin/kill /system/bin/log /system/bin/lsmod /system/bin/nandread /system/bin/netstat /system/bin/newfs_msdos /system/bin/notify /system/bin/printenv /system/bin/ps /system/bin/reboot /system/bin/renice /system/bin/rmdir /system/bin/rmmod /system/bin/route /system/bin/schedtop /system/bin/sendevent /system/bin/setconsole /system/bin/setprop /system/bin/sleep /system/bin/smd /system/bin/start /system/bin/stop /system/bin/sync /system/bin/top /system/bin/uptime /system/bin/vmstat /system/bin/watchprops /system/bin/wipe";

}
