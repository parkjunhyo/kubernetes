#! /usr/bin/env bash

CNF="./kubeadm-config.yaml"

#EHOST=("e1")
source ./admin.conf

sed -i "/controlPlaneEndpoint:.*/a\        \ keyFile: /etc/kubernetes/pki/apiserver-etcd-client.key" $CNF
sed -i "/controlPlaneEndpoint:.*/a\        \ certFile: /etc/kubernetes/pki/apiserver-etcd-client.crt" $CNF
sed -i "/controlPlaneEndpoint:.*/a\        \ caFile: /etc/kubernetes/pki/etcd/ca.crt" $CNF
for i in "${EHOST[@]}"; do
   EN=${EHOST[$i]}
   EIP=$(cat /etc/hosts | grep -i $EN | awk -F"[ ]" '{print $1}')
   sed -i "/controlPlaneEndpoint:.*/a\        \ - https://$EIP:2379" $CNF
done
sed -i "/controlPlaneEndpoint:.*/a\        \ endpoints:" $CNF
sed -i "/controlPlaneEndpoint:.*/a\    \ external:" $CNF
sed -i "/controlPlaneEndpoint:.*/aetcd:" $CNF

systemctl daemon-reload
systemctl restart kubelet
