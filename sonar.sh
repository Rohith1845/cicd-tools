#!/bin/bash


curl -fsSL https://get.docker.com -o get-docker.sh 

# this will install the sonar using docker
sh get-docker.sh 
docker run --name sonar -d sonarqube:8.9.2-community

systemctl enable sonar
systemctl start sonar

# #If the memory is full us the below commands to clear
# du -xh /var | sort -hr | head -20

# # clean the logs
# journalctl --vacuum-time=3d
# # Clean the package
# yum clean all
# #delete the unused data if docker available
# docker system df
# docker system prune -af

# systemctl stop sonarqube
# # clean broken es
# rm -rf /opt/sonarqube/data/es7/*


