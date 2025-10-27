FROM alpine:3.20

RUN apk add --no-cache \
    # Network tools
    tcpdump \
    bind-tools \
    nmap-ncat \
    curl \
    wget \
    openssh-client \
    # Development tools
    git \
    vim \
    # Database clients
    redis \
    postgresql-client \
    # Storage utilities
    nfs-utils \
    && addgroup -S toolbox \
    && adduser -S -G toolbox toolbox \
    && mkdir -p /home/toolbox \
    && chown -R toolbox:toolbox /home/toolbox \
    && rm -rf /var/cache/apk/*

SHELL ["/bin/sh", "-c"]

WORKDIR /home/toolbox

USER toolbox

CMD ["/bin/sh"]
