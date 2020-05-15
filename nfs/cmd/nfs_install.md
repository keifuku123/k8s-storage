1.安装nfs服务器

#本测试case是在master节点安装nfs
yum -y install nfs-utils

#创建nfs目录
mkdir -p /nfs/data/

#修改权限
chmod -R 777 /nfs/data

#编辑export文件,这个文件就是nfs默认的配置文件
vim /etc/exports
/nfs/data *(rw,no_root_squash,sync)

#配置生效
exportfs -r
#查看生效
exportfs

#启动rpcbind、nfs服务
systemctl restart rpcbind && systemctl enable rpcbind
systemctl restart nfs && systemctl enable nfs

#查看 RPC 服务的注册状况
rpcinfo -p localhost

#showmount测试
showmount -e 192.168.88.111


2.在所有node节点安装客户端，并配置开机自启动
yum -y install nfs-utils
systemctl start nfs && systemctl enable nfs
