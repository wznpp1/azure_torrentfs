#!/bin/bash


sudo apt-get update && sudo apt-get install -y curl unzip gcc g++ make git fuse supervisor screen

git clone https://github.com/wznpp1/azure_torrentfs.git

sudo ln -s "/home/$USER/azure_torrentfs/app" /root/app

#torrentfs
sudo source <(curl -L https://go-install.netlify.app/install.sh)
sudo go install github.com/anacrolix/torrent/cmd/torrentfs@latest
sudo cp /home/go/bin/torrentfs /root/app/anacrolix/torrentfs
sudo chmod +x /root/app/anacrolix/torrentfs

sudo rm -rf /root/.config/rclone/rclone.conf
sudo mkdir -p /root/.config/rclone/
sudo ln -s /root/app/rclone/rclone.conf /root/.config/rclone/rclone.conf
sudo ln -s /root/app/shell /root/shell

#rclone
curl https://rclone.org/install.sh | sudo bash
mkdir -p /root/app/anacrolix/downloads
mkdir -p /root/app/anacrolix/mnt

chmod +x /root/app/shell/stop.sh
chmod +x /root/app/shell/start.sh
chmod +x /root/app/shell/webdav.sh
chmod +x /root/app/shell/mount.sh

#supervisor
sudo mv /etc/supervisor/supervisord.conf /etc/supervisor/supervisord.conf.bak
sudo ln -s /root/app/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
sudo systemctl stop supervisor.service

sudo supervisord -c /etc/supervisor/supervisord.conf

sudo systemctl restart supervisor.service
sudo systemctl enable supervisor.service

#supervisorctl update
