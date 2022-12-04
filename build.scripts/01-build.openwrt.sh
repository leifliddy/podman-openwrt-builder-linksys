#!/bin/bash

find /output/ | egrep -v '^/output/$|\.gitignore' | xargs rm -rf
openwrt_dir='/root/openwrt'
openwrt_profile='linksys_wrt3200acm'

profiles=$(ls /root/profiles)

for profile in $profiles
do
    make -C $openwrt_dir clean
    packages=$(cat /root/profiles/$profile)
    echo $packages
    make -C $openwrt_dir image PROFILE=$openwrt_profile PACKAGES="$packages"
    mkdir -p /output/$profile
    find $openwrt_dir/bin/targets/ | grep squashfs-sysupgrade.bin | xargs cp -t /output/$profile
done
