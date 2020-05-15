#!/bash/bin

#创建pv卷对应的目录
mkdir -p /nfs/data/pv001

cat <<EOF >/etc/exports
/nfs/data/pv001 *(insecure,rw,no_root_squash,no_all_squash,sync)
EOF

export -r

systemctl restart rpcbind && systemctl restart nfs

#创建名称为pv001的PV卷

kubectl apply -f nfs-pv001.yaml
kubectl get pv

#创建名称为pvc001的PVC

kubectl apply -f nfs-pvc001.yaml
kubectl get pvc
kubectl get pv

#创建pod，在pod中使用存储; 验证pvc可用

kubectl apply -f nfs-pod001.yaml

sleep 120s

#验证PV是否可用
kubectl exec nfs-pod001 touch /var/www/html/index001.html
ls -l /nfs/data/pv001/


