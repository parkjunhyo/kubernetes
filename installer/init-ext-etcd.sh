#! /usr/bin/env bash

cat << EOF > /etc/systemd/system/kubelet.service.d/20-etcd-service-manager.conf
[Service]
ExecStart=
ExecStart=/usr/bin/kubelet --address=0.0.0.0 --pod-manifest-path=/etc/kubernetes/manifests --allow-privileged=true --cgroup-driver=systemd
Restart=always
EOF

systemctl daemon-reload
systemctl restart kubelet
