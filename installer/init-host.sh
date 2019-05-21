#! /usr/bin/env bash

# IPMS=("147.75.95.15" "147.75.94.13" "147.75.94.25" "147.75.94.103" "147.75.94.7")
# NNS=("m1" "e1" "w1" "w2" "w3")
source ./admin.conf

echo "" >> /etc/hosts
for i in "${!IPMS[@]}"; do
 echo ${IPMS[$i]}" "${NNS[$i]} >> /etc/hosts
done

FIP=$(ifconfig $MAINIF | grep -i "inet addr:" | awk -F"[:]" '{print $2}' | awk -F"[ ]" '{print $1;}')
HN=$(cat /etc/hosts | grep -i $FIP | awk -F"[ ]" '{print $2;}')
hostname $HN
echo $HN > /etc/hostname
sed -i "s/127.0.0.1.*/127.0.0.1 localhost $HN/" /etc/hosts
