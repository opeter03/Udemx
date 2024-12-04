FROM jenkins/jenkins:lts

USER root
RUN apt-get update && apt-get install docker.io -y && usermod -aG docker jenkins
