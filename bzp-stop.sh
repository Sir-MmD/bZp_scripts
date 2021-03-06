#!/system/bin/sh
#bZp Kill
#By Sir.MmD

#bZp location
mnt=/data/local/bzp-rootfs

#Detect Busybox
if [ -x /system/xbin/busybox ]; then
	busybox=/system/xbin/busybox
elif [ -x /sbin/busybox ]; then
	busybox=/sbin/busybox
elif [ -x /system/xbin/busybox ]; then
	busybox=/system/xbin/busybox
elif [ -x /data/local/bin/busybox ]; then
	busybox=/data/local/bin/busybox
elif [ -x /system/bin/busybox ]; then
	busybox=/system/bin/busybox
elif [ -x /su/bin/busybox ]; then
	busybox=/su/bin/busybox
else
	echo "Busybox not found!"
	exit 1
fi

#Export Environment
PRESERVED_PATH=$PATH
export PATH=/usr/bin:/usr/sbin:/bin:/usr/local/bin:/usr/local/sbin:$PATH
export TERM=linux;
export HOME=/root;
export USER=root;
export LOGNAME=root;
unset LD_PRELOAD;

$busybox chmod 666 /dev/null;
$busybox chroot $mnt /bin/bash -c "sudo service ssh stop";
$busybox chroot $mnt /bin/bash -c "sudo rm /tmp/.X0-lock";
$busybox chroot $mnt /bin/bash -c "sudo rm /tmp/.X11-unix/X0";
$busybox chroot $mnt /bin/bash -c "sudo vncserver -kill :0";
$busybox chroot $mnt /bin/bash -c "sudo service postgresql stop";
$busybox chroot $mnt /bin/bash -c "sudo clear";

#Unmount parts
$busybox umount $mnt/dev/pts;
$busybox umount $mnt/dev;
$busybox umount $mnt/dev/shm;
$busybox umount $mnt/proc;
$busybox umount $mnt/sys;
$busybox umount $mnt/sdcard;

#Clear
clear;
