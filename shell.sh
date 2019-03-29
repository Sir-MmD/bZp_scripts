#!/system/bin/sh
#bZp Shell
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
$busybox chroot $mnt /bin/bash -c "sudo clear";
$busybox chroot $mnt /bin/bash -c "sudo su";
