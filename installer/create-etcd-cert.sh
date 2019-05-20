#! /usr/bin/env bash


kubeadm init phase certs etcd-server --config=./kubeadm-etcd-config.yaml
kubeadm init phase certs etcd-peer --config=./kubeadm-etcd-config.yaml
kubeadm init phase certs etcd-healthcheck-client --config=./kubeadm-etcd-config.yaml
kubeadm init phase certs apiserver-etcd-client --config=./kubeadm-etcd-config.yaml
