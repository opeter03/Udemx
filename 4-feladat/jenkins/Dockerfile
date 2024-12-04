FROM jenkins/jenkins:lts

USER root
RUN apt-get update && apt-get install docker.io -y
RUN usermod -aG docker jenkins && chmod 777 /var/run/docker.sock
