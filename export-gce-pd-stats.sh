#!/bin/sh

disks="/dev/disk/by-id/google-*"
if [ ! -z "${ROOTFS}" ]; then
    disks=${ROOTFS}${disks}
fi

stats=""
for gce_pd in $(ls ${disks}); do
    diskStats=$(df -B1 ${gce_pd} 2>/dev/null | grep -v ^Filesystem)
    IFS=$'\n'
    for disk in ${diskStats}; do
        pd_name=$(echo $gce_pd | sed -e 's|.*by-id/google-||')
        device=$(echo $disk | awk '{print $1}')
        size=$(echo $disk | awk '{print $2}')
        used=$(echo $disk | awk '{print $3}')
        avail=$(echo $disk | awk '{print $4}')
        mountpoint=$(echo $disk | awk '{print $6}')
        if [ ! -z "${ROOTFS}" ]; then
            mountpoint=$(echo $mountpoint | sed -e "s|${ROOTFS}||")
        fi
        stats=$stats"gce_pd_size{pd_name=\"${pd_name}\",device=\"${device}\",mountpoint=\"${mountpoint}\",host=\"${host}\"} ${size}\n"
        stats=$stats"gce_pd_used{pd_name=\"${pd_name}\",device=\"${device}\",mountpoint=\"${mountpoint}\",host=\"${host}\"} ${used}\n"
        stats=$stats"gce_pd_available{pd_name=\"${pd_name}\",device=\"${device}\",mountpoint=\"${mountpoint}\",host=\"${host}\"} ${avail}\n"
    done
done
echo -e "$stats" | sort | grep -v '^$'