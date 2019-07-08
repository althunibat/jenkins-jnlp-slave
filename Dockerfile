FROM jenkins/jnlp-slave:3.29-1
LABEL Author "Hamza Althunibat <althunibat@outlook.com>"

USER root
RUN curl -fsSL https://download.docker.com/linux/debian/dists/stretch/pool/stable/amd64/docker-ce-cli_18.09.6~3-0~debian-stretch_amd64.deb > docker-ce-cli_18.09.6~3-0~debian-stretch_amd64.deb && dpkg -i docker-ce-cli_18.09.6~3-0~debian-stretch_amd64.deb
RUN curl -fsSL https://github.com/docker/compose/releases/download/1.24.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
RUN curl -L https://storage.googleapis.com/kubernetes-release/release/1.12.10/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl
 
RUN curl -L https://get.helm.sh/helm-v2.14.1-linux-amd64.tar.gz | tar zxv -C /tmp \
  && cp /tmp/linux-amd64/helm /usr/local/bin/helm \
  && chmod +x /usr/local/bin/helm

VOLUME [ "/var/run/docker.sock" ]
