#! /usr/bin/env bash

#NAMES=("w1" "w2")
source ./admin.conf

MSG=""
for i in "${!NAMES[@]}"; do
 EHOST=$(cat /etc/hosts | grep -i ${NAMES[$i]} | grep -v 'localhost' | awk -F"[ ]" '{print $1;}')
 MSG=$MSG${NAMES[$i]}=https://$EHOST:2380
 if [[ "${NAMES[$i]}" != "${NAMES[-1]}" ]]
 then
   MSG=$MSG,
 fi
done


NHOST=$(ifconfig bond0 | grep -i "inet addr:" | awk -F"[:]" '{print $2}' | awk -F"[ ]" '{print $1;}')
NAME=$(cat /etc/hosts | grep -i $NHOST | awk -F"[ ]" '{print $2;}')
MASTERIP=$(cat /etc/hosts | grep -i $MASTER_REP | grep -v 'localhost' | awk -F"[ ]" '{print $1;}'):6443

cat << EOF > ./kubeadm-etcd-config.yaml
apiVersion: "kubeadm.k8s.io/v1beta1"
kind: ClusterConfiguration
controlPlaneEndpoint: $MASTERIP
etcd:
    local:
        serverCertSANs:
        - "${NHOST}"
        peerCertSANs:
        - "${NHOST}"
        extraArgs:
            initial-cluster: $MSG
            initial-cluster-state: new
            name: ${NAME}
            listen-peer-urls: https://${NHOST}:2380
            listen-client-urls: https://${NHOST}:2379
            advertise-client-urls: https://${NHOST}:2379
            initial-advertise-peer-urls: https://${NHOST}:2380
EOF
