#!/bin/bash

sudo -s

apt-get update && apt-get install -y curl unzip gcc g++ make git fuse supervisor screen

cd /root/
git clone https://github.com/wznpp1/azure_torrentfs.git
mv /root/azure_torrentfs/app /root/app

#torrentfs
source <(curl -L https://github.com/wznpp1/azure_torrentfs/raw/main/go-install.sh)
go install github.com/anacrolix/torrent/cmd/torrentfs@latest
cp /home/go/bin/torrentfs /root/app/anacrolix/torrentfs
chmod +x /root/app/anacrolix/torrentfs

rm -rf /root/shell
rm -rf /root/.config/rclone/rclone.conf
mkdir -p /root/.config/rclone/

ln -s /root/app/rclone/rclone.conf /root/.config/rclone/rclone.conf
ln -s /root/app/shell /root/shell

#rclone
curl https://rclone.org/install.sh | bash
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
