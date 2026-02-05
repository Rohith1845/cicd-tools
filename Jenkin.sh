#!/bin/bash

growpart /dev/nvme0n1 4

lvextend -L +10G /dev/mapper/RootVG-varVol
lvextend -L +10G /dev/mapper/RootVG-rootVol
lvextend -l +100%Free /dev/mapper/RootVG-homeVol

xfs_growfs /
xfs_geowfs /var
xfs_growfs /home

curl -fsSL https://pkg.jenkins.io/redhat-stable/jenkins.repo -o /etc/yum.repos.d/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
yum install fontconfig java-21-openjdk -y
yum install jenkins -y
systemctl daemon-reload
systemctl start jenkins
systemctl enable jenkins



