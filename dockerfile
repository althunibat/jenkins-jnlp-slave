FROM jenkins/jnlp-slave:3.29-1
LABEL Author "Hamza Althunibat <althunibat@outlook.com>"

USER root
RUN apt-get install -y \
    ca-certificates \
    curl && \
    rm -rf /var/lib/apt/lists/* 
RUN curl -fsSL https://download.docker.com/linux/debian/dists/stretch/pool/stable/amd64/docker-ce-cli_18.09.6~3-0~debian-stretch_amd64.deb > docker-ce-cli_18.09.6~3-0~debian-stretch_amd64.deb && dpkg -i docker-ce-cli_18.09.6~3-0~debian-stretch_amd64.deb
RUN curl -fsSL https://github.com/docker/compose/releases/download/1.24.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

RUN chmod +x /usr/local/bin/docker-compose
VOLUME [ "/var/run/docker.sock" ]
