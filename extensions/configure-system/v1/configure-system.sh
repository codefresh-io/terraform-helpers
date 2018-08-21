#!/bin/bash
#

log_file=/tmp/mount-datadisk.out
echo log_file = $log_file
exec &> >(tee -a "$log_file")

echo -e "------- Starting $0 at $(date)"

echo "--- Kernel Parameters"
sysctl -w vm.max_map_count=262144
# sysctl -w vm.dirty_expire_centisecs = 12000
# sysctl -w vm.dirty_ratio = 80
# sysctl -w vm.swappiness = 0

# sysctl -w fs.inotify.max_user_instances = 8192
# sysctl -w fs.inotify.max_user_watches = 524288

# sysctl -w net.core.wmem_max = 16777216
# sysctl -w net.core.somaxconn = 32768
# sysctl -w net.core.wmem_max = 16777216
# sysctl -w net.core.netdev_max_backlog = 16384
# sysctl -w net.ipv4.tcp_wmem = 4096	12582912	16777216

# sysctl -w kernel.io_delay_type = 0


echo "--- Installing Ceph Client"
wget -q -O- 'https://download.ceph.com/keys/release.asc' | sudo apt-key add -

echo deb https://download.ceph.com/debian-luminous/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list
apt update
apt install ceph-common


# MOUNT_FOLDER=/opt/codefresh
# mkdir -p ${MOUNT_FOLDER}