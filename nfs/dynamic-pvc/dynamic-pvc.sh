#!/bin/bash

#部署RBAC；因为在v1.16版本之后需要RBAC

kubectl apply -f deploy/rbac.yaml

#部署nfs-client-provisioner
kubectl apply -f deploy/deployment.yaml

sleep 120s
kubectl get pod -o wide

#创建storageclass
kubectl apply -f deploy/class.yaml

kubectl get sc

#创建测试pvc

kubectl apply -f deploy/test-claim.yaml
kubectl get pvc
kubectl get pv

#创建测试pod
kubectl apply -f deploy/test-pod.yaml
kubectl get pod -o wide
