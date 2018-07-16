FROM jenkinsci/jnlp-slave:latest
MAINTAINER Hiroomi Taniguchi <hiroomi.taniguchi@gmail.com>

# chage to root for installing package
USER root

# Install docker for Stretch
# https://docs.docker.com/install/linux/docker-ce/debian/
RUN \
  apt-get update && \
  apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common && \
  curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
  add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable" && \
  apt-get update && \
  apt-get install -y docker-ce

