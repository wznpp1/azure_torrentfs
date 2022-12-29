#!/bin/bash

$(umount /root/app/anacrolix/mnt)
/root/app/anacrolix/torrentfs  -listenAddr=:8098 -mountDir=/root/app/anacrolix/mnt -metainfoDir=/root/app/anacrolix/torrents -downloadDir=/root/app/anacrolix/downloads
