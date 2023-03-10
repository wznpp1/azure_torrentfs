#!/bin/bash

ln -s "/home/$USER/app" /root/app

apt-get update && apt-get install -y curl unzip gcc g++ make git fuse supervisor screen

#torrentfs
source <(curl -L https://go-install.netlify.app/install.sh)
go install github.com/anacrolix/torrent/cmd/torrentfs@latest
cp /home/go/bin/torrentfs /root/app/anacrolix/torrentfs
chmod +x /root/app/anacrolix/torrentfs

rm -rf /root/.config/rclone/rclone.conf
mkdir -p /root/.config/rclone/
ln -s /root/app/rclone/rclone.conf /root/.config/rclone/rclone.conf
ln -s /root/app/shell /root/shell

#rclone
curl https://rclone.org/install.sh | sudo bash
mkdir -p /root/app/anacrolix/downloads
mkdir -p /root/app/anacrolix/mnt

chmod +x /root/app/shell/stop.sh
chmod +x /root/app/shell/start.sh
chmod +x /root/app/shell/webdav.sh
chmod +x /root/app/shell/mount.sh

#supervisor
mv /etc/supervisor/supervisord.conf /etc/supervisor/supervisord.conf.bak
ln -s /root/app/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
systemctl stop supervisor.service

supervisord -c /etc/supervisor/supervisord.conf

systemctl restart supervisor.service
systemctl enable supervisor.service

#supervisorctl update