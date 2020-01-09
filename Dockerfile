FROM jenkins/jnlp-slave:3.36-2
LABEL Author "Hamza Althunibat <althunibat@outlook.com>"

USER root

RUN curl -fsSL https://download.docker.com/linux/debian/dists/stretch/pool/stable/amd64/docker-ce-cli_19.03.5~3-0~debian-stretch_amd64.deb > docker-ce-cli.deb && dpkg -i docker-ce-cli.deb
RUN curl -fsSL https://github.com/docker/compose/releases/download/1.25.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
RUN curl -L https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl
 
RUN curl -L https://get.helm.sh/helm-v2.16.1-linux-amd64.tar.gz | tar zxv -C /tmp \
  && cp /tmp/linux-amd64/helm /usr/local/bin/helm \
  && chmod +x /usr/local/bin/helm

RUN helm init -c  && \
    helm repo add godwit https://charts.godwit.io && \
    helm repo add bitnami https://charts.bitnami.com/bitnami && \
    helm plugin install https://github.com/chartmuseum/helm-push

COPY install-k3d.sh /root/install-k3d.sh
RUN /root/install-k3d.sh && rm /root/install-k3d.sh

VOLUME [ "/var/run/docker.sock" ]
VOLUME [ "/root/.kube/config" ]

