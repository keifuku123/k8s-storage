#!/bin/bash

#install the package in nfs server

yum update
yum install -y nfs-utils rpcbind

mkdir -p /nfs/data/

chmod -R 777 /nfs/data

cat <<EOF >/etc/exports
/nfs/data *(insecure,rw,no_root_squash,no_all_squash,sync)
EOF

export -r

systemctl restart rpcbind && systemctl enable rpcbind
systemctl restart nfs && systemctl enable nfs

showmount -e localhost
