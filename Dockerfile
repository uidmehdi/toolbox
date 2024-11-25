FROM alpine:3.20
LABEL maintainer="Mehdi Hassanpour"

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
    && rm -rf /var/cache/apk/*

SHELL ["/bin/sh", "-c"]

# RUN adduser -D appuser
# USER appuser

CMD ["/bin/sh"]
