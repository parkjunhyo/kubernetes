#! /usr/bin/env bash

sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
echo "======================1========================="
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo "======================2========================="
sudo apt-key fingerprint 0EBFCD88
echo "======================3========================="
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
echo "=======================4========================"
sudo apt-get update
echo "=======================5========================"
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
echo "=======================6========================"  
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
echo "=======================7========================"
mkdir -p /etc/systemd/system/docker.service.d
echo "=======================8========================"
systemctl daemon-reload
systemctl restart docker
docker version
