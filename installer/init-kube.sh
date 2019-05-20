#! /usr/bin/env bash

apt-get update && apt-get install -y apt-transport-https curl
echo "======================1========================="
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "======================2========================="
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
echo "======================3========================="
apt-get update
echo "======================4========================="
apt-get install -y kubelet kubeadm kubectl
echo "======================5========================="
apt-mark hold kubelet kubeadm kubectl
echo "======================6========================="
echo "net.bridge.bridge-nf-call-iptables=1" >> /etc/sysctl.conf
sysctl -p /etc/sysctl.conf
kubeadm config images pull
swapoff -a
