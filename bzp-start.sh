#!/system/bin/sh
#bZp Executor
#By Sir.MmD

#bZp location
mnt=/data/local/bzp-rootfs

#Export Environment
PRESERVED_PATH=$PATH
export PATH=/usr/bin:/usr/sbin:/bin:/usr/local/bin:/usr/local/sbin:$PATH
export TERM=linux;
export HOME=/root;
export USER=root;
export LOGNAME=root;
unset LD_PRELOAD;

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


#Hostname
hostname bZp;

#Setting up tty
chmod a+rw /dev/tty;

#Check for null
if [ ! -f "$/dev/null" ]; then
  mknod /dev/null/ c 1 3
fi

#Check for shm
if [ ! -d "$/dev/shm" ]; then
  mkdir /dev/shm
fi

#Mount parts
$busybox mount -o remount,suid /data;
$busybox mount -o bind /dev $mnt/dev;
$busybox mount -t devpts devpts $mnt/dev/pts;
$busybox mount -t tmpfs shmfs $mnt/dev/shm;
$busybox mount -t proc proc $mnt/proc;
$busybox mount -t sysfs sysfs $mnt/sys;
$busybox mount -o bind /sdcard $mnt/sdcard;
$busybox chmod 666 /dev/null

$busybox sysctl -w kernel.shmmax=268435456

#Start SSH server
$busybox chroot $mnt /bin/bash -c "sudo service ssh stop";
$busybox chroot $mnt /bin/bash -c "sudo service ssh start";

#Start VNC server
$busybox chroot $mnt /bin/bash -c "sudo rm /tmp/.X0-lock";
$busybox chroot $mnt /bin/bash -c "sudo rm /tmp/.X11-unix/X0";
$busybox chroot $mnt /bin/bash -c "sudo vncserver -kill :0";
$busybox chroot $mnt /bin/bash -c "sudo vncserver -geometry 1440x950 :0";

#Start PostgreSQL
$busybox chroot $mnt /bin/bash -c "sudo service postgresql start";

#Clear
$busybox chroot $mnt /bin/bash -c "sudo clear";

#Show SSH & VNC ip
echo "SSH server: ";
$busybox ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'
echo "VNC server: ";
$busybox ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'
