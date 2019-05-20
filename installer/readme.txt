# This is the installation script to build kubernetes environments

# Update for Sample Pem Key
- create-sample-pem.sh

# For Master nodes and Clustering 

- create-sample-pem.sh
- init-host.sh
- init-docker.sh
- init-kube.sh
- init-yaml.sh
- init-master.sh
- enable-kubectl.sh
- enable-flannel.sh

# For External ETCD nodes and Clustering

- create-sample-pem.sh
- init-host.sh
- init-docker.sh
- init-kube.sh
- init-ext-etcd.sh
- init-etcd-yaml.sh
- create-etcd-ca.sh
- create-etcd-cert.sh
- update-etcd-config.sh

# After ETCD nodes installation, Master nodes should be updated, which redirect to these

- update-config-after-ext-etcd.sh

# For Worker nodes

- create-sample-pem.sh
- init-host.sh
- init-docker.sh
- init-kube.sh
