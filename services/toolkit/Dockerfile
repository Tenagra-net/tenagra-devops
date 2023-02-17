FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ "Etc\UTC"

# Prerequisites
RUN apt-get update && \
    apt-get install -y curl git gnupg python3 python3-pip software-properties-common wget

# Install Ansible
RUN python3 -m pip install ansible && \
    apt-get install -y sshpass

# Install Terraform / Packer / Vault / Consul
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
RUN apt-get update && \
    apt-get install -y consul packer terraform vault

# Install Repo
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /bin/repo && \
    chmod a+rx /bin/repo && \
    update-alternatives --install /usr/bin/python python $(which python3) 10