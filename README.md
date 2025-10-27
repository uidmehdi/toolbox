# Alpine Utility Container

## Overview
Lightweight Alpine Linux-based container with essential network, development, and database tools.

## Features
- Network tools: tcpdump, bind-tools, nmap-ncat
- Development utilities: git, vim
- Database clients: Redis, PostgreSQL
- Storage support: NFS utils

## Build & Deployment
### Docker Build
```bash
docker build -t toolbox .
```

### GitHub Container Registry
Automatically builds multi-arch images for:
- Linux x86_64 
- Linux ARM64

## Image Tags
- `latest`: Most recent build
- `alpine<version>`: Specific Alpine version
- Branch and PR specific tags

## Usage
Run the image interactively:
```bash
docker run --rm -it uidmehdi/toolbox
```

The container starts as an unprivileged user (`toolbox`) for safety. Override that when needed:
```bash
docker run --rm -it --user root uidmehdi/toolbox
```

Attach a working directory from the host to make the utilities more useful:
```bash
docker run --rm -it -v "$PWD":/workspace -w /workspace uidmehdi/toolbox
```
