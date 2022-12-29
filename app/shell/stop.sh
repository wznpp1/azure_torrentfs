#!/bin/bash

supervisorctl stop mount
supervisorctl stop webdav

umount /root/app/anacrolix/mnt
rm -rf /root/app/rclone/mnt/*
rm -rf /root/app/anacrolix/downloads/*20*