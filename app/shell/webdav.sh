#!/bin/bash
rm -rf /root/app/anacrolix/downloads/*2019*
rm -rf /root/app/anacrolix/downloads/*2020*
rm -rf /root/app/anacrolix/downloads/*2021*
rm -rf /root/app/anacrolix/downloads/*2022*

rm -rf /root/app/rclone/mnt/*
mkdir -p /root/app/rclone/mnt/2019/
mkdir -p /root/app/rclone/mnt/2020/
mkdir -p /root/app/rclone/mnt/2022/

ln -s /root/app/anacrolix/mnt/*2019* /root/app/rclone/mnt/2019/
ln -s /root/app/anacrolix/mnt/*2020* /root/app/rclone/mnt/2020/
ln -s /root/app/anacrolix/mnt/*2021* /root/app/rclone/mnt/2021/
ln -s /root/app/anacrolix/mnt/*2022* /root/app/rclone/mnt/2022/

ln -s /root/app/anacrolix /root/app/rclone/mnt/anacrolix

/usr/bin/rclone serve webdav /root/app/rclone/mnt --copy-links --read-only --addr :8001