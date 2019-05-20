#! /usr/bin/env bash

FIP=$(ifconfig bond0 | grep -i "inet addr:" | awk -F"[:]" '{print $2}' | awk -F"[ ]" '{print $1;}')
cat <<EOF > ./kubeadm-config.yaml
apiVersion: kubeadm.k8s.io/v1beta1
kind: InitConfiguration
localAPIEndpoint:
  advertiseAddress: $FIP
  bindPort: 6443
---
apiVersion: kubeadm.k8s.io/v1beta1
kind: ClusterConfiguration
kubernetesVersion: v1.14.1
clusterName: crenet-cluster
controlPlaneEndpoint: $FIP:6443
networking:
  podSubnet: 10.244.0.0/16
controllerManager:
  extraArgs:
    deployment-controller-sync-period: "50s"
---
apiVersion: kubelet.config.k8s.io/v1beta1
kind: KubeletConfiguration
cgroupDriver: systemd
EOF
wget https://raw.githubusercontent.com/coreos/flannel/a70459be0084506e4ec919aa1c114638878db11b/Documentation/kube-flannel.yml
