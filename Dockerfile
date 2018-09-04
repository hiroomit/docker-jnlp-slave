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

# Install Azure CLI
RUN \
  AZ_REPO=$(lsb_release -cs) && \
  echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
    tee /etc/apt/sources.list.d/azure-cli.list && \
  curl -L https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
  apt-get install -y apt-transport-https && \
  apt-get update && apt-get install azure-cli

# Install misc package
RUN \
  apt-get install -y sshpass

# Update jenkins-slave
COPY slave.jar /usr/share/jenkins/slave.jar
RUN chmod 644 /usr/share/jenkins/slave.jar
