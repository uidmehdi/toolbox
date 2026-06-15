# Alpine Utility Container

[![Docker Image CI](https://github.com/uidmehdi/toolbox/actions/workflows/docker-image.yml/badge.svg)](https://github.com/uidmehdi/toolbox/actions/workflows/docker-image.yml)

## Overview
Lightweight Alpine Linux-based container with essential network, development, and database tools. Available in two variants: a minimal base image and an Azure CLI-enabled version.

## Variants

### Base Image (`toolbox`)
Minimal toolbox with core utilities for network diagnostics, development, and database operations.

### Azure CLI Image (`toolbox-azure`)
Extended variant including Azure CLI installed via `uv` for cloud operations and infrastructure management.

## Features

### Common to Both Variants
- **Network tools**: tcpdump, bind-tools, nmap-ncat, curl, wget, openssl, openssh-client
- **Development utilities**: git, vim
- **Database clients**: Redis, PostgreSQL
- **Storage support**: NFS utils
- **Security**: Runs as unprivileged user (`toolbox`)

### Azure Variant Additional Features
- Azure CLI (latest version via uv)
- Python 3 runtime

## Build & Deployment

### Docker Build

**Base image:**
```bash
docker build -t toolbox -f Dockerfile .
```

**Azure variant:**
```bash
docker build -t toolbox-azure -f Dockerfile.azure .
```

### Automated Builds
Images are automatically built and published via GitHub Actions with:
- Multi-architecture support (x86_64, ARM64)
- Security scanning via Trivy
- SBOM and provenance attestation
- Build caching for faster iterations

## Image Tags

### Docker Hub
- `uidmehdi/toolbox:latest` - Base image, latest build
- `uidmehdi/toolbox:alpine<version>` - Base image, specific Alpine version
- `uidmehdi/toolbox-azure:latest` - Azure variant, latest build
- `uidmehdi/toolbox-azure:alpine<version>` - Azure variant, specific Alpine version

### GitHub Container Registry
- `ghcr.io/uidmehdi/toolbox:latest` - Base image, latest build
- `ghcr.io/uidmehdi/toolbox:alpine<version>` - Base image, specific Alpine version
- `ghcr.io/uidmehdi/toolbox-azure:latest` - Azure variant, latest build
- `ghcr.io/uidmehdi/toolbox-azure:alpine<version>` - Azure variant, specific Alpine version

Branch and PR builds are tagged accordingly for testing.

## Usage

### Basic Interactive Shell

**Base image:**
```bash
docker run --rm -it uidmehdi/toolbox
```

**Azure variant:**
```bash
docker run --rm -it uidmehdi/toolbox-azure
```

### Run as Root
The container starts as an unprivileged user (`toolbox`) for safety. Override when elevated privileges are needed:
```bash
docker run --rm -it --user root uidmehdi/toolbox
```

### Mount Working Directory
Attach a working directory from the host to make the utilities more useful:
```bash
docker run --rm -it -v "$PWD":/workspace -w /workspace uidmehdi/toolbox
```

### Azure CLI Usage
```bash
# Interactive shell with Azure CLI
docker run --rm -it uidmehdi/toolbox-azure

# Run Azure CLI command directly
docker run --rm -it uidmehdi/toolbox-azure az --version

# Mount Azure config for authenticated sessions
docker run --rm -it -v ~/.azure:/home/toolbox/.azure uidmehdi/toolbox-azure az account show
```

### Network Diagnostics
```bash
# Run tcpdump
docker run --rm -it --cap-add=NET_RAW --net=host uidmehdi/toolbox tcpdump -i any

# DNS lookup
docker run --rm -it uidmehdi/toolbox dig example.com
```

### Database Operations
```bash
# Connect to PostgreSQL
docker run --rm -it uidmehdi/toolbox psql -h db.example.com -U username

# Connect to Redis
docker run --rm -it uidmehdi/toolbox redis-cli -h redis.example.com
```

## Kubernetes Deployment

### Debugging Pod
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: toolbox
spec:
  containers:
  - name: toolbox
    image: uidmehdi/toolbox:latest
    command: ["/bin/sh"]
    args: ["-c", "sleep infinity"]
```

### Azure Operations Pod
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: toolbox-azure
spec:
  containers:
  - name: toolbox
    image: uidmehdi/toolbox-azure:latest
    command: ["/bin/sh"]
    args: ["-c", "sleep infinity"]
```

Execute commands:
```bash
kubectl exec -it toolbox -- /bin/sh
kubectl exec -it toolbox-azure -- az --version
```

## Security

- Images are scanned with Trivy for vulnerabilities
- SBOM (Software Bill of Materials) available for all builds
- Provenance attestation enabled
- Runs as non-root user by default
- Minimal attack surface with Alpine Linux base
